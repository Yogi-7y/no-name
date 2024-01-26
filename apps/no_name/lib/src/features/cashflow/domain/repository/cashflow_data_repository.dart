import '../../../../core/result.dart';
import '../entity/raw_cashflow_data.dart';

abstract class CashflowDataRespository {
  AsyncResult<List<RawCashflowData>> getCashflowDescription();
}
