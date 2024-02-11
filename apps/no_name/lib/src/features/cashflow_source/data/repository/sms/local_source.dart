import 'package:isar/isar.dart';

import '../../../../../core/result.dart';
import '../../../../../services/local_state/local_state_service.dart';
import '../../../domain/entity/raw_cashflow_data.dart';
import '../../../domain/repository/cashflow_source_repository.dart';
import '../../models/raw_cashflow_adapter.dart';

const _cashflowLastStoredDateTimeKey = 'cashflow_last_stored_date_time';

class CashflowLocalSourceImpl implements CashflowLocalSource {
  const CashflowLocalSourceImpl({
    required this.isar,
    required this.localStateService,
  });

  final Isar isar;
  final LocalStateService localStateService;

  @override
  AsyncResult<List<RawCashflowData>> getCashflow() async {
    final _cashflow = await isar.rawCashflow
        .filter()
        .stateEqualTo(RawCashflowDataState.failed)
        .or()
        .stateEqualTo(RawCashflowDataState.notBackedUp)
        .findAll();

    return Success(value: _cashflow);
  }

  @override
  AsyncResult<DateTime?> getLastLocalStoreCashflowDateTime() async {
    final _dateTime = await localStateService.readString(_cashflowLastStoredDateTimeKey);

    if (_dateTime == null) return const Success();

    final _parsedDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(_dateTime));

    return Success(value: _parsedDateTime);
  }

  @override
  AsyncResult<void> storeCashflow({required List<RawCashflowData> cashflow}) async {
    final _cashflow = cashflow.map(RawCashflowAdapter.fromRawCashflowData).toList();

    await isar.writeTxn(() => isar.rawCashflow.putAll(_cashflow));

    return const Success();
  }

  @override
  AsyncResult<void> writeLocalCashflowDataTime({required DateTime dateTime}) async {
    await localStateService.writeString(
      key: _cashflowLastStoredDateTimeKey,
      value: dateTime.millisecondsSinceEpoch.toString(),
    );

    return const Success();
  }
}
