import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/local/database.dart';
import '../../../data/repositories/food_repository.dart';

final searchQueryProvider = StateProvider.autoDispose<String>((_) => '');

final _debouncedQueryProvider =
    StreamProvider.autoDispose<String>((ref) async* {
  final ctrl = StreamController<String>();
  Timer? timer;
  ref.listen<String>(searchQueryProvider, (_, next) {
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 300), () => ctrl.add(next));
  }, fireImmediately: true);
  ref.onDispose(() {
    timer?.cancel();
    ctrl.close();
  });
  yield* ctrl.stream;
});

final searchResultsProvider =
    FutureProvider.autoDispose<List<Food>>((ref) async {
  final q = await ref.watch(_debouncedQueryProvider.future);
  return ref.watch(foodRepositoryProvider).search(q);
});

final favoritesProvider = FutureProvider.autoDispose<List<Food>>((ref) {
  return ref.watch(foodRepositoryProvider).getFavorites();
});

final recentsProvider = FutureProvider.autoDispose<List<Food>>((ref) {
  return ref.watch(foodRepositoryProvider).getRecentlyUsed();
});
