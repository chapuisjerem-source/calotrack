import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/date_utils.dart';
import '../../../data/local/database.dart';
import '../../../data/repositories/food_repository.dart';
import '../../../data/repositories/meal_repository.dart';

enum MealType {
  breakfast('breakfast', 'Petit-déjeuner'),
  lunch('lunch', 'Déjeuner'),
  snack('snack', 'Collation'),
  dinner('dinner', 'Dîner');

  final String value;
  final String label;
  const MealType(this.value, this.label);

  static MealType fromTime(DateTime t) {
    final h = t.hour;
    if (h < 10) return MealType.breakfast;
    if (h < 14) return MealType.lunch;
    if (h < 18) return MealType.snack;
    return MealType.dinner;
  }

  static MealType fromString(String s) =>
      MealType.values.firstWhere((m) => m.value == s,
          orElse: () => MealType.snack);
}

final selectedFoodProvider =
    FutureProvider.autoDispose.family<Food, int>((ref, id) async {
  return ref.watch(foodRepositoryProvider).getById(id);
});

class AddQuantityState {
  final double quantityG;
  final MealType mealType;
  final DateTime date;
  final bool saving;
  final String? error;

  const AddQuantityState({
    required this.quantityG,
    required this.mealType,
    required this.date,
    this.saving = false,
    this.error,
  });

  AddQuantityState copyWith({
    double? quantityG,
    MealType? mealType,
    DateTime? date,
    bool? saving,
    String? error,
  }) {
    return AddQuantityState(
      quantityG: quantityG ?? this.quantityG,
      mealType: mealType ?? this.mealType,
      date: date ?? this.date,
      saving: saving ?? this.saving,
      error: error,
    );
  }
}

class AddQuantityViewModel extends StateNotifier<AddQuantityState> {
  final FoodRepository _foodRepo;
  final MealRepository _mealRepo;

  AddQuantityViewModel(this._foodRepo, this._mealRepo)
      : super(AddQuantityState(
          quantityG: 100,
          mealType: MealType.fromTime(DateTime.now()),
          date: AppDateUtils.today(),
        ));

  void setQuantity(double q) => state = state.copyWith(quantityG: q);
  void setMealType(MealType m) => state = state.copyWith(mealType: m);
  void setDate(DateTime d) =>
      state = state.copyWith(date: AppDateUtils.dayOnly(d));

  Future<bool> save(int foodId) async {
    if (state.quantityG <= 0) {
      state = state.copyWith(error: 'La quantité doit être supérieure à 0');
      return false;
    }
    state = state.copyWith(saving: true, error: null);
    try {
      // Conserve l'heure courante pour faciliter l'affichage chronologique.
      final now = DateTime.now();
      final dateWithTime = DateTime(
        state.date.year,
        state.date.month,
        state.date.day,
        now.hour,
        now.minute,
      );
      await _mealRepo.addEntry(
        foodId: foodId,
        date: dateWithTime,
        mealType: state.mealType.value,
        quantityG: state.quantityG,
      );
      await _foodRepo.touchLastUsed(foodId);
      state = state.copyWith(saving: false);
      return true;
    } catch (e) {
      state = state.copyWith(saving: false, error: e.toString());
      return false;
    }
  }
}

final addQuantityViewModelProvider = StateNotifierProvider.autoDispose<
    AddQuantityViewModel, AddQuantityState>((ref) {
  return AddQuantityViewModel(
    ref.watch(foodRepositoryProvider),
    ref.watch(mealRepositoryProvider),
  );
});
