import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/date_utils.dart';
import '../../../data/repositories/meal_repository.dart';
import '../../../data/repositories/weight_repository.dart';
import '../../profile/viewmodel/profile_viewmodel.dart';

final _last7DaysProvider =
    FutureProvider.autoDispose<List<_DayKcal>>((ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  final today = AppDateUtils.today();
  final result = <_DayKcal>[];
  for (int i = 6; i >= 0; i--) {
    final day = today.subtract(Duration(days: i));
    // Consomme un instant du stream pour obtenir le jour courant.
    final items = await repo.watchDay(day).first;
    final totals = repo.computeTotals(items);
    result.add(_DayKcal(day: day, kcal: totals.kcal));
  }
  return result;
});

class _DayKcal {
  final DateTime day;
  final double kcal;
  const _DayKcal({required this.day, required this.kcal});
}

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final daysAsync = ref.watch(_last7DaysProvider);
    final profileAsync = ref.watch(userProfileProvider);
    final weightsAsync = ref.watch(weightEntriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Historique')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(_last7DaysProvider);
          ref.invalidate(weightEntriesProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Calories — 7 derniers jours',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: daysAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Erreur : $e')),
                data: (days) {
                  final target =
                      profileAsync.asData?.value?.dailyCalorieGoal.toDouble();
                  return _KcalBarChart(days: days, target: target);
                },
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text('Poids',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Ajouter'),
                  onPressed: () => _addWeightSheet(context, ref),
                ),
              ],
            ),
            const SizedBox(height: 8),
            weightsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Erreur : $e'),
              data: (entries) {
                if (entries.isEmpty) {
                  return const Card(
                    child: ListTile(
                      leading: Icon(Icons.monitor_weight_outlined),
                      title: Text('Aucun poids enregistré'),
                      subtitle: Text(
                          'Ajoutez votre poids pour suivre son évolution'),
                    ),
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: _WeightChart(entries: entries),
                    ),
                    const SizedBox(height: 12),
                    ...entries.take(10).map((w) => ListTile(
                          dense: true,
                          title: Text(
                              '${w.weightKg.toStringAsFixed(1)} kg'),
                          subtitle: Text(AppDateUtils.formatDay(w.date)),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () async {
                              await ref
                                  .read(weightRepositoryProvider)
                                  .delete(w.id);
                            },
                          ),
                        )),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addWeightSheet(BuildContext context, WidgetRef ref) async {
    final ctrl = TextEditingController();
    DateTime date = AppDateUtils.today();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Ajouter un poids',
                      style: Theme.of(ctx).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    controller: ctrl,
                    autofocus: true,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Poids (kg)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today),
                    title: Text(AppDateUtils.formatDay(date)),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: date,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setSheetState(() => date = AppDateUtils.dayOnly(picked));
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      final v = double.tryParse(
                          ctrl.text.replaceAll(',', '.'));
                      if (v == null || v <= 0) return;
                      await ref
                          .read(weightRepositoryProvider)
                          .addOrUpdate(date: date, weightKg: v);
                      if (ctx.mounted) Navigator.of(ctx).pop();
                    },
                    child: const Text('Enregistrer'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _KcalBarChart extends StatelessWidget {
  final List<_DayKcal> days;
  final double? target;
  const _KcalBarChart({required this.days, required this.target});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final maxY = () {
      double m = 0;
      for (final d in days) {
        if (d.kcal > m) m = d.kcal;
      }
      if (target != null && target! > m) m = target!;
      return (m * 1.15).clamp(500, double.infinity);
    }();

    return BarChart(
      BarChartData(
        maxY: maxY.toDouble(),
        barGroups: List.generate(days.length, (i) {
          final d = days[i];
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: d.kcal,
                color: primary,
                width: 18,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        }),
        extraLinesData: target == null
            ? const ExtraLinesData()
            : ExtraLinesData(horizontalLines: [
                HorizontalLine(
                  y: target!,
                  color: Colors.orange,
                  strokeWidth: 2,
                  dashArray: [6, 4],
                  label: HorizontalLineLabel(
                    show: true,
                    labelResolver: (_) => 'Obj. ${target!.round()}',
                    style: const TextStyle(color: Colors.orange),
                  ),
                ),
              ]),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (v, _) =>
                  Text(v.toInt().toString(),
                      style: const TextStyle(fontSize: 10)),
            ),
          ),
          topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i < 0 || i >= days.length) return const SizedBox.shrink();
                final label = DateFormat.E('fr_FR').format(days[i].day);
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(label,
                      style: const TextStyle(fontSize: 10)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _WeightChart extends StatelessWidget {
  final List<dynamic> entries;
  const _WeightChart({required this.entries});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    // Entries viennent triées DESC dans watchAll → on inverse pour le graph.
    final sorted = [...entries].reversed.toList();
    final spots = <FlSpot>[];
    for (int i = 0; i < sorted.length; i++) {
      spots.add(FlSpot(i.toDouble(), (sorted[i].weightKg as double)));
    }
    double minY = spots.isEmpty ? 0 : spots.first.y;
    double maxY = spots.isEmpty ? 0 : spots.first.y;
    for (final s in spots) {
      if (s.y < minY) minY = s.y;
      if (s.y > maxY) maxY = s.y;
    }
    return LineChart(
      LineChartData(
        minY: (minY - 1).floorToDouble(),
        maxY: (maxY + 1).ceilToDouble(),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (v, _) => Text(
                  v.toStringAsFixed(0),
                  style: const TextStyle(fontSize: 10)),
            ),
          ),
          topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false)),
          bottomTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            color: primary,
            barWidth: 3,
            isCurved: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: primary.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );
  }
}
