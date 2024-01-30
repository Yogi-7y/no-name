import 'package:isar/isar.dart';

import '../../domain/entity/persistence_state.dart';

part 'persistence_state_adapter.g.dart';

@collection
class PersistenceStateAdapter extends PersistenceState {
  const PersistenceStateAdapter({
    required super.lastPersistenceTime,
    this.id = Isar.autoIncrement,
  });

  final Id id;
}
