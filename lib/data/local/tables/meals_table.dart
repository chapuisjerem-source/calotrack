import 'package:drift/drift.dart';
import 'foods_table.dart';

class MealEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get foodId =>
      integer().references(Foods, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  TextColumn get mealType =>
      text()(); // 'breakfast' | 'lunch' | 'snack' | 'dinner'
  RealColumn get quantityG => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
