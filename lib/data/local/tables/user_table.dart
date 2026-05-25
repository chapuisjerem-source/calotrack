import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sex => text()(); // 'male' | 'female'
  IntColumn get age => integer()();
  RealColumn get heightCm => real()();
  RealColumn get weightKg => real()();
  TextColumn get activityLevel => text()(); // enum name
  TextColumn get goal => text()(); // enum name
  IntColumn get dailyCalorieGoal => integer()();
  IntColumn get proteinGoal => integer()();
  IntColumn get carbsGoal => integer()();
  IntColumn get fatGoal => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
