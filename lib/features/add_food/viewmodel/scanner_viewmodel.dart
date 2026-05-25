import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/failures.dart';
import '../../../data/local/database.dart';
import '../../../data/repositories/food_repository.dart';

sealed class ScannerState {
  const ScannerState();
}

class ScannerIdle extends ScannerState {
  const ScannerIdle();
}

class ScannerLoading extends ScannerState {
  final String barcode;
  const ScannerLoading(this.barcode);
}

class ScannerSuccess extends ScannerState {
  final Food food;
  const ScannerSuccess(this.food);
}

class ScannerError extends ScannerState {
  final Failure failure;
  const ScannerError(this.failure);
}

class ScannerViewModel extends StateNotifier<ScannerState> {
  final FoodRepository _repo;
  ScannerViewModel(this._repo) : super(const ScannerIdle());

  Future<void> handleBarcode(String code) async {
    if (state is ScannerLoading) return;
    state = ScannerLoading(code);
    try {
      final food = await _repo.findOrFetchByBarcode(code);
      state = ScannerSuccess(food);
    } on Failure catch (f) {
      state = ScannerError(f);
    } catch (_) {
      state = const ScannerError(UnknownFailure());
    }
  }

  void reset() => state = const ScannerIdle();
}

final scannerViewModelProvider =
    StateNotifierProvider.autoDispose<ScannerViewModel, ScannerState>((ref) {
  return ScannerViewModel(ref.watch(foodRepositoryProvider));
});
