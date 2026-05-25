import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/tdee_calculator.dart';
import '../../profile/viewmodel/profile_viewmodel.dart';
import 'widgets/onboarding_step.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _step = 0;

  Sex _sex = Sex.female;
  final _ageCtrl = TextEditingController(text: '30');
  final _heightCtrl = TextEditingController(text: '170');
  final _weightCtrl = TextEditingController(text: '70');
  ActivityLevel _activity = ActivityLevel.light;
  Goal _goal = Goal.maintain;

  static const int _totalSteps = 6;

  @override
  void dispose() {
    _pageController.dispose();
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_step < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    } else {
      _save();
    }
  }

  void _prev() {
    if (_step > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _save() async {
    final age = int.tryParse(_ageCtrl.text) ?? 30;
    final height = double.tryParse(_heightCtrl.text.replaceAll(',', '.')) ?? 170;
    final weight = double.tryParse(_weightCtrl.text.replaceAll(',', '.')) ?? 70;

    final form = ProfileFormData(
      sex: _sex,
      age: age,
      heightCm: height,
      weightKg: weight,
      activity: _activity,
      goal: _goal,
    );
    await ref.read(profileViewModelProvider.notifier).save(form);
  }

  int get _tdeePreview {
    final age = int.tryParse(_ageCtrl.text) ?? 30;
    final height = double.tryParse(_heightCtrl.text.replaceAll(',', '.')) ?? 170;
    final weight = double.tryParse(_weightCtrl.text.replaceAll(',', '.')) ?? 70;
    final tdee = TdeeCalculator.calculateTDEE(
      sex: _sex,
      age: age,
      weightKg: weight,
      heightCm: height,
      activity: _activity,
    );
    return TdeeCalculator.calculateDailyGoal(tdee: tdee, goal: _goal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progression
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: List.generate(_totalSteps, (i) {
                  final active = i <= _step;
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(right: i == _totalSteps - 1 ? 0 : 4),
                      decoration: BoxDecoration(
                        color: active
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
              ),
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _step = i),
                children: [
                  _buildSexStep(),
                  _buildAgeStep(),
                  _buildHeightStep(),
                  _buildWeightStep(),
                  _buildActivityStep(),
                  _buildGoalStep(),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (_step > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _prev,
                        child: const Text('Retour'),
                      ),
                    ),
                  if (_step > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _next,
                      child: Text(_step == _totalSteps - 1
                          ? 'Terminer'
                          : 'Suivant'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSexStep() {
    return OnboardingStep(
      title: 'Quel est votre sexe ?',
      subtitle: 'Cette information est utilisée pour estimer votre métabolisme.',
      child: Column(
        children: [
          _sexTile(Sex.female, 'Femme', Icons.female),
          const SizedBox(height: 12),
          _sexTile(Sex.male, 'Homme', Icons.male),
        ],
      ),
    );
  }

  Widget _sexTile(Sex value, String label, IconData icon) {
    final selected = _sex == value;
    return InkWell(
      onTap: () => setState(() => _sex = value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          color: selected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.08)
              : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            if (selected)
              Icon(Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeStep() {
    return OnboardingStep(
      title: 'Votre âge ?',
      subtitle: 'En années.',
      child: TextField(
        controller: _ageCtrl,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Âge'),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildHeightStep() {
    return OnboardingStep(
      title: 'Votre taille ?',
      subtitle: 'En centimètres.',
      child: TextField(
        controller: _heightCtrl,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Taille (cm)'),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildWeightStep() {
    return OnboardingStep(
      title: 'Votre poids actuel ?',
      subtitle: 'En kilogrammes.',
      child: TextField(
        controller: _weightCtrl,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Poids (kg)'),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildActivityStep() {
    return OnboardingStep(
      title: 'Niveau d\'activité ?',
      subtitle: 'Activité physique moyenne sur la semaine.',
      child: ListView(
        children: ActivityLevel.values
            .map((a) => _activityTile(a))
            .toList(),
      ),
    );
  }

  Widget _activityTile(ActivityLevel a) {
    final selected = _activity == a;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => setState(() => _activity = a),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.shade300,
              width: selected ? 2 : 1,
            ),
            color: selected
                ? Theme.of(context).colorScheme.primary.withOpacity(0.08)
                : null,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(a.label,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Text(a.description,
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              if (selected)
                Icon(Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalStep() {
    return OnboardingStep(
      title: 'Votre objectif ?',
      subtitle: 'Nous calculerons vos besoins caloriques en conséquence.',
      child: Column(
        children: [
          ...Goal.values.map(_goalTile),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text('Objectif calorique journalier',
                    style: TextStyle(color: Colors.grey.shade700)),
                const SizedBox(height: 6),
                Text(
                  '$_tdeePreview kcal',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _goalTile(Goal g) {
    final selected = _goal == g;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => setState(() => _goal = g),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.shade300,
              width: selected ? 2 : 1,
            ),
            color: selected
                ? Theme.of(context).colorScheme.primary.withOpacity(0.08)
                : null,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(g.label,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Text(g.description,
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              if (selected)
                Icon(Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
