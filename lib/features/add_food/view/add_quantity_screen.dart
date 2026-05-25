import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../viewmodel/add_quantity_viewmodel.dart';

class AddQuantityScreen extends ConsumerStatefulWidget {
  final int foodId;
  const AddQuantityScreen({super.key, required this.foodId});

  @override
  ConsumerState<AddQuantityScreen> createState() => _AddQuantityScreenState();
}

class _AddQuantityScreenState extends ConsumerState<AddQuantityScreen> {
  late final TextEditingController _qtyCtrl;

  @override
  void initState() {
    super.initState();
    _qtyCtrl = TextEditingController(text: '100');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addQuantityViewModelProvider.notifier).setQuantity(100);
    });
  }

  @override
  void dispose() {
    _qtyCtrl.dispose();
    super.dispose();
  }

  void _applyQuantity(String text) {
    final q = double.tryParse(text.replaceAll(',', '.')) ?? 0;
    ref.read(addQuantityViewModelProvider.notifier).setQuantity(q);
  }

  @override
  Widget build(BuildContext context) {
    final foodAsync = ref.watch(selectedFoodProvider(widget.foodId));
    final state = ref.watch(addQuantityViewModelProvider);
    final vm = ref.read(addQuantityViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Quantité')),
      body: foodAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
        data: (food) {
          final qty = state.quantityG;
          final kcal = food.kcalPer100g * qty / 100;
          final prot = food.proteinPer100g * qty / 100;
          final carbs = food.carbsPer100g * qty / 100;
          final fat = food.fatPer100g * qty / 100;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(food.name,
                    style: Theme.of(context).textTheme.headlineSmall),
                if (food.brand != null)
                  Text(food.brand!,
                      style: TextStyle(color: Colors.grey.shade600)),
                const SizedBox(height: 4),
                Text('${food.kcalPer100g.toStringAsFixed(0)} kcal / 100 g',
                    style: TextStyle(color: Colors.grey.shade700)),
                const SizedBox(height: 24),
                TextField(
                  controller: _qtyCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Quantité (g)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _applyQuantity,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [50, 100, 150, 200, 250].map((v) {
                    return OutlinedButton(
                      onPressed: () {
                        _qtyCtrl.text = v.toString();
                        _applyQuantity(_qtyCtrl.text);
                      },
                      child: Text('$v g'),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<MealType>(
                  value: state.mealType,
                  decoration: const InputDecoration(
                    labelText: 'Repas',
                    border: OutlineInputBorder(),
                  ),
                  items: MealType.values
                      .map((m) => DropdownMenuItem(
                          value: m, child: Text(m.label)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) vm.setMealType(v);
                  },
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Date'),
                  subtitle: Text(DateFormat.yMMMMEEEEd('fr_FR')
                      .format(state.date)),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: state.date,
                      firstDate: DateTime.now()
                          .subtract(const Duration(days: 365)),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) vm.setDate(picked);
                  },
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _row('Calories', '${kcal.round()} kcal'),
                        _row(
                            'Protéines', '${prot.toStringAsFixed(1)} g'),
                        _row('Glucides',
                            '${carbs.toStringAsFixed(1)} g'),
                        _row('Lipides', '${fat.toStringAsFixed(1)} g'),
                      ],
                    ),
                  ),
                ),
                if (state.error != null) ...[
                  const SizedBox(height: 8),
                  Text(state.error!,
                      style: const TextStyle(color: Colors.red)),
                ],
                const Spacer(),
                SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check),
                    label: Text(state.saving
                        ? 'Enregistrement...'
                        : 'Ajouter au journal'),
                    onPressed: state.saving
                        ? null
                        : () async {
                            final ok = await vm.save(widget.foodId);
                            if (ok && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Ajouté au journal'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              context.go('/');
                            }
                          },
                  ),
                ),
              ],
            ),
          );
        },
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
