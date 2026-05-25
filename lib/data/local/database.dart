import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'seed_foods.dart';
import 'tables/foods_table.dart';
import 'tables/meals_table.dart';
import 'tables/user_table.dart';
import 'tables/weight_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Users, Foods, MealEntries, WeightEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedFoods();
        },
      );

  Future<void> _seedFoods() async {
    for (final f in kSeedFoods) {
      await into(foods).insert(
        FoodsCompanion.insert(
          name: f.name,
          kcalPer100g: f.kcal,
          proteinPer100g: f.protein,
          carbsPer100g: f.carbs,
          fatPer100g: f.fat,
          source: 'seed',
        ),
      );
    }
  }
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'calotrack');
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
