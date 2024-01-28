import '../../../../core/result.dart';
import '../entity/cashflow_entry.dart';
import '../entity/raw_cashflow_data.dart';

abstract class CashflowTransformRepository {
  AsyncResult<List<CashflowEntry>> transformToCashflowEntry({
    required List<RawCashflowData> rawData,
  });
}
