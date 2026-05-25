import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local/database.dart';

class UserRepository {
  final AppDatabase _db;
  UserRepository(this._db);

  Stream<User?> watchProfile() {
    final stmt = _db.select(_db.users)..limit(1);
    return stmt.watchSingleOrNull();
  }

  Future<User?> getProfile() {
    final stmt = _db.select(_db.users)..limit(1);
    return stmt.getSingleOrNull();
  }

  Future<void> saveProfile({
    required String sex,
    required int age,
    required double heightCm,
    required double weightKg,
    required String activityLevel,
    required String goal,
    required int dailyCalorieGoal,
    required int proteinGoal,
    required int carbsGoal,
    required int fatGoal,
  }) async {
    final existing = await getProfile();
    if (existing == null) {
      await _db.into(_db.users).insert(
            UsersCompanion.insert(
              sex: sex,
              age: age,
              heightCm: heightCm,
              weightKg: weightKg,
              activityLevel: activityLevel,
              goal: goal,
              dailyCalorieGoal: dailyCalorieGoal,
              proteinGoal: proteinGoal,
              carbsGoal: carbsGoal,
              fatGoal: fatGoal,
            ),
          );
    } else {
      await (_db.update(_db.users)..where((t) => t.id.equals(existing.id)))
          .write(
        UsersCompanion(
          sex: Value(sex),
          age: Value(age),
          heightCm: Value(heightCm),
          weightKg: Value(weightKg),
          activityLevel: Value(activityLevel),
          goal: Value(goal),
          dailyCalorieGoal: Value(dailyCalorieGoal),
          proteinGoal: Value(proteinGoal),
          carbsGoal: Value(carbsGoal),
          fatGoal: Value(fatGoal),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(appDatabaseProvider));
});
