import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/food_repository.dart';

class ManualFoodState {
  final bool saving;
  final String? error;
  final int? createdFoodId;
  const ManualFoodState({this.saving = false, this.error, this.createdFoodId});

  ManualFoodState copyWith({
    bool? saving,
    String? error,
    int? createdFoodId,
  }) =>
      ManualFoodState(
        saving: saving ?? this.saving,
        error: error,
        createdFoodId: createdFoodId ?? this.createdFoodId,
      );
}

class ManualFoodViewModel extends StateNotifier<ManualFoodState> {
  final FoodRepository _repo;
  ManualFoodViewModel(this._repo) : super(const ManualFoodState());

  Future<int?> save({
    required String name,
    required double kcal,
    required double protein,
    required double carbs,
    required double fat,
  }) async {
    if (name.trim().isEmpty) {
      state = state.copyWith(error: 'Nom requis');
      return null;
    }
    state = state.copyWith(saving: true, error: null);
    try {
      final id = await _repo.createManual(
        name: name.trim(),
        kcal: kcal,
        protein: protein,
        carbs: carbs,
        fat: fat,
      );
      state = state.copyWith(saving: false, createdFoodId: id);
      return id;
    } catch (e) {
      state = state.copyWith(saving: false, error: e.toString());
      return null;
    }
  }
}

final manualFoodViewModelProvider =
    StateNotifierProvider.autoDispose<ManualFoodViewModel, ManualFoodState>(
        (ref) {
  return ManualFoodViewModel(ref.watch(foodRepositoryProvider));
});
