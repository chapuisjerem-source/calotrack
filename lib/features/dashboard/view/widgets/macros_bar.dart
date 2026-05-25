import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class MacrosBar extends StatelessWidget {
  final double protein;
  final double carbs;
  final double fat;
  final int proteinGoal;
  final int carbsGoal;
  final int fatGoal;

  const MacrosBar({
    super.key,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.proteinGoal,
    required this.carbsGoal,
    required this.fatGoal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _macro('Protéines', protein, proteinGoal, AppColors.protein),
        const SizedBox(height: 10),
        _macro('Glucides', carbs, carbsGoal, AppColors.carbs),
        const SizedBox(height: 10),
        _macro('Lipides', fat, fatGoal, AppColors.fat),
      ],
    );
  }

  Widget _macro(String label, double current, int goal, Color color) {
    final ratio =
        goal == 0 ? 0.0 : (current / goal).clamp(0.0, 1.0).toDouble();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            const Spacer(),
            Text('${current.toStringAsFixed(0)} / $goal g',
                style: TextStyle(color: Colors.grey.shade700)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: ratio),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            builder: (_, v, __) => LinearProgressIndicator(
              value: v,
              minHeight: 8,
              backgroundColor: color.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
      ],
    );
  }
}
