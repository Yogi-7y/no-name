import 'package:isar/isar.dart';

import '../../../../core/result.dart';
import '../../domain/entity/persistence_state.dart';
import '../../domain/entity/raw_cashflow_data.dart';
import '../../domain/repository/cashflow_persistence_repository.dart';
import '../../domain/repository/cashflow_source_repository.dart';
import '../models/raw_cashflow_data.dart';

class IsarCashflowPersistenceRepository implements CashflowPersistenceRepository {
  const IsarCashflowPersistenceRepository({required this.isar});
  final Isar isar;

  @override
  AsyncResult<void> saveCashflow({
    required List<RawCashflowData> cashflow,
  }) async {
    final _transformedData = cashflow.map(RawCashflowAdapter.fromRawCashflowData).toList();

    // ignore: unused_local_variable
    final _result = await isar.writeTxn(() {
      return isar.rawCashflowAdapters.putAll(_transformedData);
    });

    return const Success();
  }

  @override
  AsyncResult<List<RawCashflowData>> getBackedUpCashflow() async {
    final _backedUpCashflow = await isar.rawCashflowAdapters
        .filter()
        .stateContains(
          RawCashflowDataState.backedUp.name,
          caseSensitive: false,
        )
        .findAll();

    return Success(value: _backedUpCashflow);
  }

  @override
  AsyncResult<List<RawCashflowData>> getNotBackedUpCashflow() async {
    final _notBackedUpCashflow = await isar.rawCashflowAdapters
        .filter()
        .stateContains(
          RawCashflowDataState.notBackedUp.name,
          caseSensitive: false,
        )
        .findAll();

    return Success(value: _notBackedUpCashflow);
  }

  @override
  AsyncResult<PersistenceState> getLastPersistenceTime() async {
    return Success(
        value: PersistenceState(
      lastPersistenceTime: DateTime.now().subtract(const Duration(days: 1)),
    ));
  }

  @override
  AsyncResult<void> logPersistenceTime() {
    throw UnimplementedError();
  }
}
