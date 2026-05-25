import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/repositories/meal_repository.dart';
import '../../../add_food/viewmodel/add_quantity_viewmodel.dart';

class MealList extends ConsumerWidget {
  final List<MealEntryWithFood> items;
  const MealList({super.key, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.restaurant_outlined,
                  size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 12),
              Text('Aucun repas enregistré',
                  style: TextStyle(color: Colors.grey.shade600)),
              const SizedBox(height: 4),
              Text('Ajoutez un aliment pour commencer.',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
            ],
          ),
        ),
      );
    }

    final Map<MealType, List<MealEntryWithFood>> grouped = {
      for (final m in MealType.values) m: [],
    };
    for (final it in items) {
      grouped[MealType.fromString(it.entry.mealType)]!.add(it);
    }

    return Column(
      children: MealType.values.map((type) {
        final list = grouped[type]!;
        if (list.isEmpty) return const SizedBox.shrink();
        final totalKcal = list.fold<double>(0, (acc, e) => acc + e.kcal);
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            children: [
              ListTile(
                title: Text(type.label,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text('${totalKcal.round()} kcal',
                    style: TextStyle(color: Colors.grey.shade700)),
              ),
              ...list.map((it) => Dismissible(
                    key: ValueKey('entry-${it.entry.id}'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      color: Colors.redAccent,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (_) async {
                      return await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Supprimer ?'),
                              content: Text(
                                  'Retirer "${it.food.name}" du journal ?'),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('Annuler')),
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text('Supprimer')),
                              ],
                            ),
                          ) ??
                          false;
                    },
                    onDismissed: (_) async {
                      await ref
                          .read(mealRepositoryProvider)
                          .deleteEntry(it.entry.id);
                    },
                    child: ListTile(
                      title: Text(it.food.name),
                      subtitle: Text(
                          '${it.entry.quantityG.toStringAsFixed(0)} g • P ${it.protein.toStringAsFixed(0)}  G ${it.carbs.toStringAsFixed(0)}  L ${it.fat.toStringAsFixed(0)}'),
                      trailing: Text('${it.kcal.round()} kcal',
                          style:
                              const TextStyle(fontWeight: FontWeight.w600)),
                      onTap: () => context.push('/edit-entry/${it.entry.id}'),
                    ),
                  )),
              const SizedBox(height: 8),
            ],
          ),
        );
      }).toList(),
    );
  }
}
