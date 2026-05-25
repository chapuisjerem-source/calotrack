import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../viewmodel/manual_food_viewmodel.dart';

class ManualFoodScreen extends ConsumerStatefulWidget {
  const ManualFoodScreen({super.key});

  @override
  ConsumerState<ManualFoodScreen> createState() => _ManualFoodScreenState();
}

class _ManualFoodScreenState extends ConsumerState<ManualFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _kcalCtrl = TextEditingController();
  final _protCtrl = TextEditingController();
  final _carbsCtrl = TextEditingController();
  final _fatCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _kcalCtrl.dispose();
    _protCtrl.dispose();
    _carbsCtrl.dispose();
    _fatCtrl.dispose();
    super.dispose();
  }

  double _parse(TextEditingController c) =>
      double.tryParse(c.text.replaceAll(',', '.')) ?? 0;

  String? _validateNumber(String? v, {bool required = true}) {
    if (v == null || v.trim().isEmpty) {
      return required ? 'Requis' : null;
    }
    final n = double.tryParse(v.replaceAll(',', '.'));
    if (n == null || n < 0) return 'Valeur invalide';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(manualFoodViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Aliment personnalisé')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nom de l\'aliment',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Requis' : null,
              ),
              const SizedBox(height: 16),
              Text('Valeurs pour 100 g',
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              TextFormField(
                controller: _kcalCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Calories (kcal)',
                  border: OutlineInputBorder(),
                ),
                validator: _validateNumber,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _protCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Protéines (g)',
                  border: OutlineInputBorder(),
                ),
                validator: _validateNumber,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _carbsCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Glucides (g)',
                  border: OutlineInputBorder(),
                ),
                validator: _validateNumber,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _fatCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Lipides (g)',
                  border: OutlineInputBorder(),
                ),
                validator: _validateNumber,
              ),
              if (state.error != null) ...[
                const SizedBox(height: 12),
                Text(state.error!,
                    style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 24),
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: Text(state.saving
                      ? 'Enregistrement...'
                      : 'Créer et ajouter'),
                  onPressed: state.saving
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) return;
                          final id = await ref
                              .read(manualFoodViewModelProvider.notifier)
                              .save(
                                name: _nameCtrl.text,
                                kcal: _parse(_kcalCtrl),
                                protein: _parse(_protCtrl),
                                carbs: _parse(_carbsCtrl),
                                fat: _parse(_fatCtrl),
                              );
                          if (id != null && mounted) {
                            context.replace('/add-food/quantity/$id');
                          }
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
