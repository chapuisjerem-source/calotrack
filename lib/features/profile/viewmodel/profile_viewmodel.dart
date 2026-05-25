import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/tdee_calculator.dart';
import '../../../data/local/database.dart';
import '../../../data/repositories/user_repository.dart';

/// Stream du profil utilisateur (null = pas encore onboarded)
final userProfileProvider = StreamProvider<User?>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return repo.watchProfile();
});

class ProfileFormData {
  final Sex sex;
  final int age;
  final double heightCm;
  final double weightKg;
  final ActivityLevel activity;
  final Goal goal;

  const ProfileFormData({
    required this.sex,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.activity,
    required this.goal,
  });

  factory ProfileFormData.fromUser(User u) => ProfileFormData(
        sex: u.sex == 'male' ? Sex.male : Sex.female,
        age: u.age,
        heightCm: u.heightCm,
        weightKg: u.weightKg,
        activity: ActivityLevel.values
            .firstWhere((a) => a.name == u.activityLevel,
                orElse: () => ActivityLevel.light),
        goal: Goal.values
            .firstWhere((g) => g.name == u.goal, orElse: () => Goal.maintain),
      );

  ProfileFormData copyWith({
    Sex? sex,
    int? age,
    double? heightCm,
    double? weightKg,
    ActivityLevel? activity,
    Goal? goal,
  }) =>
      ProfileFormData(
        sex: sex ?? this.sex,
        age: age ?? this.age,
        heightCm: heightCm ?? this.heightCm,
        weightKg: weightKg ?? this.weightKg,
        activity: activity ?? this.activity,
        goal: goal ?? this.goal,
      );
}

class ProfileViewModel extends StateNotifier<AsyncValue<void>> {
  final UserRepository _repo;
  ProfileViewModel(this._repo) : super(const AsyncData(null));

  Future<void> save(ProfileFormData data) async {
    state = const AsyncLoading();
    try {
      final tdee = TdeeCalculator.calculateTDEE(
        sex: data.sex,
        age: data.age,
        weightKg: data.weightKg,
        heightCm: data.heightCm,
        activity: data.activity,
      );
      final daily = TdeeCalculator.calculateDailyGoal(
        tdee: tdee,
        goal: data.goal,
      );
      final macros = TdeeCalculator.calculateMacros(
        dailyCalories: daily,
        weightKg: data.weightKg,
      );
      await _repo.saveProfile(
        sex: data.sex == Sex.male ? 'male' : 'female',
        age: data.age,
        heightCm: data.heightCm,
        weightKg: data.weightKg,
        activityLevel: data.activity.name,
        goal: data.goal.name,
        dailyCalorieGoal: daily,
        proteinGoal: macros.protein,
        carbsGoal: macros.carbs,
        fatGoal: macros.fat,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, AsyncValue<void>>((ref) {
  return ProfileViewModel(ref.watch(userRepositoryProvider));
});
