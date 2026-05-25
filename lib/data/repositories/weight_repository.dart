import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/date_utils.dart';
import '../local/database.dart';

class WeightRepository {
  final AppDatabase _db;
  WeightRepository(this._db);

  Stream<List<WeightEntry>> watchAll() {
    final stmt = _db.select(_db.weightEntries)
      ..orderBy([
        (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
      ]);
    return stmt.watch();
  }

  Future<void> addOrUpdate({
    required DateTime date,
    required double weightKg,
    String? note,
  }) async {
    final d = AppDateUtils.dayOnly(date);
    final existing = await (_db.select(_db.weightEntries)
          ..where((t) => t.date.equals(d)))
        .getSingleOrNull();
    if (existing == null) {
      await _db.into(_db.weightEntries).insert(
            WeightEntriesCompanion.insert(
              date: d,
              weightKg: weightKg,
              note: Value(note),
            ),
          );
    } else {
      await (_db.update(_db.weightEntries)..where((t) => t.id.equals(existing.id)))
          .write(WeightEntriesCompanion(
        weightKg: Value(weightKg),
        note: Value(note),
      ));
    }
  }

  Future<void> delete(int id) async {
    await (_db.delete(_db.weightEntries)..where((t) => t.id.equals(id))).go();
  }
}

final weightRepositoryProvider = Provider<WeightRepository>((ref) {
  return WeightRepository(ref.watch(appDatabaseProvider));
});

final weightEntriesProvider =
    StreamProvider.autoDispose<List<WeightEntry>>((ref) {
  return ref.watch(weightRepositoryProvider).watchAll();
});
