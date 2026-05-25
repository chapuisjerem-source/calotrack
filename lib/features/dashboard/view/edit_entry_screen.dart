import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/local/database.dart';
import '../../../data/repositories/food_repository.dart';
import '../../../data/repositories/meal_repository.dart';
import '../../add_food/viewmodel/add_quantity_viewmodel.dart';

class EditEntryScreen extends ConsumerStatefulWidget {
  final int entryId;
  const EditEntryScreen({super.key, required this.entryId});

  @override
  ConsumerState<EditEntryScreen> createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends ConsumerState<EditEntryScreen> {
  MealEntry? _entry;
  Food? _food;
  final _qtyCtrl = TextEditingController();
  MealType _mealType = MealType.snack;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final mealRepo = ref.read(mealRepositoryProvider);
    final foodRepo = ref.read(foodRepositoryProvider);
    final entry = await mealRepo.getById(widget.entryId);
    if (entry == null) return;
    final food = await foodRepo.getById(entry.foodId);
    setState(() {
      _entry = entry;
      _food = food;
      _qtyCtrl.text = entry.quantityG.toStringAsFixed(0);
      _mealType = MealType.fromString(entry.mealType);
    });
  }

  @override
  void dispose() {
    _qtyCtrl.dispose();
    super.dispose();
  }

  double get _qty =>
      double.tryParse(_qtyCtrl.text.replaceAll(',', '.')) ?? 0;

  Future<void> _save() async {
    if (_entry == null) return;
    await ref.read(mealRepositoryProvider).updateEntry(
          id: _entry!.id,
          quantityG: _qty,
          mealType: _mealType.value,
        );
    if (mounted) context.pop();
  }

  Future<void> _delete() async {
    if (_entry == null) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Supprimer ?'),
        content: const Text('Retirer cet aliment du journal ?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annuler')),
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Supprimer')),
        ],
      ),
    );
    if (confirm != true) return;
    await ref.read(mealRepositoryProvider).deleteEntry(_entry!.id);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final food = _food;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier'),
        actions: [
          IconButton(
              icon: const Icon(Icons.delete_outline), onPressed: _delete),
        ],
      ),
      body: food == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(food.name,
                      style: Theme.of(context).textTheme.headlineSmall),
                  if (food.brand != null)
                    Text(food.brand!,
                        style: TextStyle(color: Colors.grey.shade600)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _qtyCtrl,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'Quantité (g)'),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<MealType>(
                    value: _mealType,
                    decoration: const InputDecoration(labelText: 'Repas'),
                    items: MealType.values
                        .map((m) => DropdownMenuItem(
                            value: m, child: Text(m.label)))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _mealType = v ?? MealType.snack),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _row('Calories',
                              '${(food.kcalPer100g * _qty / 100).round()} kcal'),
                          _row('Protéines',
                              '${(food.proteinPer100g * _qty / 100).toStringAsFixed(1)} g'),
                          _row('Glucides',
                              '${(food.carbsPer100g * _qty / 100).toStringAsFixed(1)} g'),
                          _row('Lipides',
                              '${(food.fatPer100g * _qty / 100).toStringAsFixed(1)} g'),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _save,
                    child: const Text('Enregistrer'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _row(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Expanded(
                child:
                    Text(k, style: const TextStyle(color: Colors.grey))),
            Text(v, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      );
}
