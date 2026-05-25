import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/date_utils.dart';
import '../../../data/local/database.dart';
import '../../../data/repositories/meal_repository.dart';
import '../../profile/viewmodel/profile_viewmodel.dart';

/// Date actuellement sélectionnée sur le dashboard
final selectedDateProvider =
    StateProvider<DateTime>((ref) => AppDateUtils.today());

/// Stream des repas du jour sélectionné
final dailyMealsProvider =
    StreamProvider<List<MealEntryWithFood>>((ref) {
  final day = ref.watch(selectedDateProvider);
  return ref.watch(mealRepositoryProvider).watchDay(day);
});

/// Totaux journaliers
final dailyTotalsProvider = Provider<DailyTotals>((ref) {
  final meals = ref.watch(dailyMealsProvider).asData?.value ?? const [];
  return ref.watch(mealRepositoryProvider).computeTotals(meals);
});

class DashboardSummary {
  final DailyTotals totals;
  final User? user;
  const DashboardSummary({required this.totals, required this.user});

  int get kcalGoal => user?.dailyCalorieGoal ?? 2000;
  int get proteinGoal => user?.proteinGoal ?? 100;
  int get carbsGoal => user?.carbsGoal ?? 250;
  int get fatGoal => user?.fatGoal ?? 70;

  int get kcalConsumed => totals.kcal.round();
  int get kcalRemaining => (kcalGoal - kcalConsumed).clamp(-100000, 100000);
  double get kcalRatio =>
      kcalGoal == 0 ? 0 : (kcalConsumed / kcalGoal).clamp(0.0, 1.5);
}

final dashboardSummaryProvider = Provider<DashboardSummary>((ref) {
  final totals = ref.watch(dailyTotalsProvider);
  final user = ref.watch(userProfileProvider).asData?.value;
  return DashboardSummary(totals: totals, user: user);
});
