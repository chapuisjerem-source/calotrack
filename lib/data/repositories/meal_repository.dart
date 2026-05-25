import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/date_utils.dart';
import '../local/database.dart';

class MealEntryWithFood {
  final MealEntry entry;
  final Food food;
  const MealEntryWithFood({required this.entry, required this.food});

  double get kcal => food.kcalPer100g * entry.quantityG / 100;
  double get protein => food.proteinPer100g * entry.quantityG / 100;
  double get carbs => food.carbsPer100g * entry.quantityG / 100;
  double get fat => food.fatPer100g * entry.quantityG / 100;
}

class DailyTotals {
  final double kcal;
  final double protein;
  final double carbs;
  final double fat;
  const DailyTotals({
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  static const DailyTotals empty =
      DailyTotals(kcal: 0, protein: 0, carbs: 0, fat: 0);
}

class MealRepository {
  final AppDatabase _db;
  MealRepository(this._db);

  Stream<List<MealEntryWithFood>> watchDay(DateTime day) {
    final start = AppDateUtils.dayOnly(day);
    final end = start.add(const Duration(days: 1));
    final query = _db.select(_db.mealEntries).join([
      innerJoin(_db.foods, _db.foods.id.equalsExp(_db.mealEntries.foodId)),
    ])
      ..where(_db.mealEntries.date.isBetweenValues(start, end))
      ..orderBy([
        OrderingTerm(expression: _db.mealEntries.date),
      ]);
    return query.watch().map((rows) {
      return rows
          .map((r) => MealEntryWithFood(
                entry: r.readTable(_db.mealEntries),
                food: r.readTable(_db.foods),
              ))
          .toList();
    });
  }

  Future<MealEntry?> getById(int id) {
    return (_db.select(_db.mealEntries)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> addEntry({
    required int foodId,
    required DateTime date,
    required String mealType,
    required double quantityG,
  }) {
    return _db.into(_db.mealEntries).insert(
          MealEntriesCompanion.insert(
            foodId: foodId,
            date: date,
            mealType: mealType,
            quantityG: quantityG,
          ),
        );
  }

  Future<void> updateEntry({
    required int id,
    required double quantityG,
    required String mealType,
  }) {
    return (_db.update(_db.mealEntries)..where((t) => t.id.equals(id))).write(
      MealEntriesCompanion(
        quantityG: Value(quantityG),
        mealType: Value(mealType),
      ),
    );
  }

  Future<void> deleteEntry(int id) async {
    await (_db.delete(_db.mealEntries)..where((t) => t.id.equals(id))).go();
  }

  DailyTotals computeTotals(List<MealEntryWithFood> items) {
    double k = 0, p = 0, c = 0, f = 0;
    for (final e in items) {
      k += e.kcal;
      p += e.protein;
      c += e.carbs;
      f += e.fat;
    }
    return DailyTotals(kcal: k, protein: p, carbs: c, fat: f);
  }
}

final mealRepositoryProvider = Provider<MealRepository>((ref) {
  return MealRepository(ref.watch(appDatabaseProvider));
});
