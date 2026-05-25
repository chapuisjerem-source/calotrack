import 'package:drift/drift.dart';

class Foods extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get brand => text().nullable()();
  TextColumn get barcode => text().nullable().unique()();
  RealColumn get kcalPer100g => real()();
  RealColumn get proteinPer100g => real()();
  RealColumn get carbsPer100g => real()();
  RealColumn get fatPer100g => real()();
  TextColumn get source => text()(); // 'seed' | 'openfoodfacts' | 'manual'
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUsed => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
