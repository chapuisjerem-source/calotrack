import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/tdee_calculator.dart';
import '../../../data/local/database.dart';
import '../viewmodel/profile_viewmodel.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: profileAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('Profil non configuré'));
          }
          return _ProfileContent(user: user);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
      ),
    );
  }
}

class _ProfileContent extends ConsumerWidget {
  final User user;
  const _ProfileContent({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activity = ActivityLevel.values.firstWhere(
      (a) => a.name == user.activityLevel,
      orElse: () => ActivityLevel.light,
    );
    final goal = Goal.values.firstWhere(
      (g) => g.name == user.goal,
      orElse: () => Goal.maintain,
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Objectifs',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                _row('Calories / jour', '${user.dailyCalorieGoal} kcal'),
                _row('Protéines', '${user.proteinGoal} g'),
                _row('Glucides', '${user.carbsGoal} g'),
                _row('Lipides', '${user.fatGoal} g'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Informations personnelles',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                _row('Sexe', user.sex == 'male' ? 'Homme' : 'Femme'),
                _row('Âge', '${user.age} ans'),
                _row('Taille', '${user.heightCm.toStringAsFixed(0)} cm'),
                _row('Poids', '${user.weightKg.toStringAsFixed(1)} kg'),
                _row('Activité', activity.label),
                _row('Objectif', goal.label),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.edit),
          label: const Text('Modifier mes informations'),
          onPressed: () => _showEditSheet(context, ref, user),
        ),
      ],
    );
  }

  Widget _row(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(k, style: const TextStyle(color: Colors.grey)),
            ),
            Text(v, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      );

  void _showEditSheet(BuildContext context, WidgetRef ref, User user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _EditProfileSheet(user: user),
    );
  }
}

class _EditProfileSheet extends ConsumerStatefulWidget {
  final User user;
  const _EditProfileSheet({required this.user});

  @override
  ConsumerState<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends ConsumerState<_EditProfileSheet> {
  late ProfileFormData _data;
  late TextEditingController _ageCtrl;
  late TextEditingController _heightCtrl;
  late TextEditingController _weightCtrl;

  @override
  void initState() {
    super.initState();
    _data = ProfileFormData.fromUser(widget.user);
    _ageCtrl = TextEditingController(text: _data.age.toString());
    _heightCtrl = TextEditingController(text: _data.heightCm.toString());
    _weightCtrl = TextEditingController(text: _data.weightKg.toString());
  }

  @override
  void dispose() {
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      builder: (_, controller) => SingleChildScrollView(
        controller: controller,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text('Modifier le profil',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            DropdownButtonFormField<Sex>(
              value: _data.sex,
              decoration: const InputDecoration(labelText: 'Sexe'),
              items: const [
                DropdownMenuItem(value: Sex.female, child: Text('Femme')),
                DropdownMenuItem(value: Sex.male, child: Text('Homme')),
              ],
              onChanged: (v) =>
                  setState(() => _data = _data.copyWith(sex: v ?? Sex.female)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ageCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Âge'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _heightCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Taille (cm)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _weightCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Poids (kg)'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<ActivityLevel>(
              value: _data.activity,
              decoration: const InputDecoration(labelText: 'Activité'),
              items: ActivityLevel.values
                  .map((a) => DropdownMenuItem(value: a, child: Text(a.label)))
                  .toList(),
              onChanged: (v) => setState(
                  () => _data = _data.copyWith(activity: v ?? _data.activity)),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<Goal>(
              value: _data.goal,
              decoration: const InputDecoration(labelText: 'Objectif'),
              items: Goal.values
                  .map((g) => DropdownMenuItem(value: g, child: Text(g.label)))
                  .toList(),
              onChanged: (v) => setState(
                  () => _data = _data.copyWith(goal: v ?? _data.goal)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final age = int.tryParse(_ageCtrl.text) ?? _data.age;
                final h = double.tryParse(
                        _heightCtrl.text.replaceAll(',', '.')) ??
                    _data.heightCm;
                final w = double.tryParse(
                        _weightCtrl.text.replaceAll(',', '.')) ??
                    _data.weightKg;
                final updated = _data.copyWith(
                  age: age,
                  heightCm: h,
                  weightKg: w,
                );
                await ref
                    .read(profileViewModelProvider.notifier)
                    .save(updated);
                if (context.mounted) Navigator.of(context).pop();
              },
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
