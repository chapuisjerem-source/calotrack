import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local/database.dart';
import '../remote/dto/off_product_dto.dart';
import '../remote/open_food_facts_api.dart';

class FoodRepository {
  final AppDatabase _db;
  final OpenFoodFactsApi _api;

  FoodRepository(this._db, this._api);

  Future<List<Food>> search(String query, {int limit = 30}) async {
    final q = query.trim();
    if (q.isEmpty) {
      final stmt = _db.select(_db.foods)
        ..orderBy([(t) => OrderingTerm(expression: t.name)])
        ..limit(limit);
      return stmt.get();
    }
    final pattern = '%${q.toLowerCase()}%';
    final stmt = _db.select(_db.foods)
      ..where((t) => t.name.lower().like(pattern))
      ..orderBy([(t) => OrderingTerm(expression: t.name)])
      ..limit(limit);
    return stmt.get();
  }

  Future<Food?> findByBarcode(String barcode) async {
    final stmt = _db.select(_db.foods)
      ..where((t) => t.barcode.equals(barcode))
      ..limit(1);
    return stmt.getSingleOrNull();
  }

  /// Cherche en local, sinon appelle l'API Open Food Facts et enregistre.
  Future<Food> findOrFetchByBarcode(String barcode) async {
    final existing = await findByBarcode(barcode);
    if (existing != null) return existing;

    final OffProductDto dto = await _api.fetchProduct(barcode);
    final id = await _db.into(_db.foods).insert(
          FoodsCompanion.insert(
            name: (dto.name?.trim().isEmpty ?? true)
                ? 'Produit $barcode'
                : dto.name!.trim(),
            brand: Value(dto.brand),
            barcode: Value(dto.code ?? barcode),
            kcalPer100g: dto.kcalPer100g ?? 0,
            proteinPer100g: dto.proteinPer100g ?? 0,
            carbsPer100g: dto.carbsPer100g ?? 0,
            fatPer100g: dto.fatPer100g ?? 0,
            source: 'openfoodfacts',
          ),
        );
    return (await (_db.select(_db.foods)..where((t) => t.id.equals(id))).getSingle());
  }

  Future<Food> getById(int id) {
    return (_db.select(_db.foods)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<int> createManual({
    required String name,
    required double kcal,
    required double protein,
    required double carbs,
    required double fat,
  }) {
    return _db.into(_db.foods).insert(
          FoodsCompanion.insert(
            name: name,
            kcalPer100g: kcal,
            proteinPer100g: protein,
            carbsPer100g: carbs,
            fatPer100g: fat,
            source: 'manual',
          ),
        );
    }

  Future<void> toggleFavorite(int foodId) async {
    final f = await getById(foodId);
    await (_db.update(_db.foods)..where((t) => t.id.equals(foodId)))
        .write(FoodsCompanion(isFavorite: Value(!f.isFavorite)));
  }

  Future<void> touchLastUsed(int foodId) async {
    await (_db.update(_db.foods)..where((t) => t.id.equals(foodId)))
        .write(FoodsCompanion(lastUsed: Value(DateTime.now())));
  }

  Future<List<Food>> getFavorites({int limit = 50}) {
    final stmt = _db.select(_db.foods)
      ..where((t) => t.isFavorite.equals(true))
      ..orderBy([(t) => OrderingTerm(expression: t.name)])
      ..limit(limit);
    return stmt.get();
  }

  Future<List<Food>> getRecentlyUsed({int limit = 20}) {
    final stmt = _db.select(_db.foods)
      ..where((t) => t.lastUsed.isNotNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.lastUsed, mode: OrderingMode.desc),
      ])
      ..limit(limit);
    return stmt.get();
  }
}

final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  return FoodRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(openFoodFactsApiProvider),
  );
});
