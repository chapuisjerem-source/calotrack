import 'package:drift/drift.dart';

class WeightEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().unique()();
  RealColumn get weightKg => real()();
  TextColumn get note => text().nullable()();
}
