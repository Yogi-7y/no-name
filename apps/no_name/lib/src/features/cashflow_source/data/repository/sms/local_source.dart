import '../../../../../core/result.dart';
import '../../../domain/entity/raw_cashflow_data.dart';
import '../../../domain/repository/cashflow_source_repository.dart';

class CashflowLocalSourceImpl implements CashflowLocalSource {
  @override
  AsyncResult<List<RawCashflowData>> getCashflow() {
    throw UnimplementedError();
  }

  @override
  AsyncResult<DateTime> getLastLocalStoreCashflowDateTime() {
    throw UnimplementedError();
  }

  @override
  AsyncResult<void> storeCashflow({required List<RawCashflowData> cashflow}) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<void> writeLocalCashflowDataTime({required DateTime dateTime}) {
    throw UnimplementedError();
  }
}
