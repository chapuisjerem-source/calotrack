import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_utils.dart';
import '../../viewmodel/dashboard_viewmodel.dart';

class DaySelector extends ConsumerWidget {
  const DaySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final day = ref.watch(selectedDateProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            ref.read(selectedDateProvider.notifier).state =
                day.subtract(const Duration(days: 1));
          },
        ),
        TextButton.icon(
          icon: const Icon(Icons.calendar_today, size: 18),
          label: Text(
            AppDateUtils.relativeDay(day),
            style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: day,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
              locale: const Locale('fr', 'FR'),
            );
            if (picked != null) {
              ref.read(selectedDateProvider.notifier).state =
                  AppDateUtils.dayOnly(picked);
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            ref.read(selectedDateProvider.notifier).state =
                day.add(const Duration(days: 1));
          },
        ),
      ],
    );
  }
}
