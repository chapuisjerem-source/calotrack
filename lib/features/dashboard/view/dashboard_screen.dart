import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../viewmodel/dashboard_viewmodel.dart';
import 'widgets/calorie_ring.dart';
import 'widgets/day_selector.dart';
import 'widgets/macros_bar.dart';
import 'widgets/meal_list.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsAsync = ref.watch(dailyMealsProvider);
    final summary = ref.watch(dashboardSummaryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('CaloTrack')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add-food'),
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dailyMealsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          children: [
            const DaySelector(),
            const SizedBox(height: 12),
            Center(
              child: CalorieRing(
                consumed: summary.kcalConsumed,
                goal: summary.kcalGoal,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: MacrosBar(
                  protein: summary.totals.protein,
                  carbs: summary.totals.carbs,
                  fat: summary.totals.fat,
                  proteinGoal: summary.proteinGoal,
                  carbsGoal: summary.carbsGoal,
                  fatGoal: summary.fatGoal,
                ),
              ),
            ),
            const SizedBox(height: 12),
            mealsAsync.when(
              data: (items) => MealList(items: items),
              loading: () => const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Center(child: Text('Erreur : $e')),
            ),
          ],
        ),
      ),
    );
  }
}
