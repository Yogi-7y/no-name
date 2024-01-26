import '../../../../core/result.dart';
import '../../domain/entity/raw_cashflow_data.dart';
import '../../domain/repository/cashflow_data_repository.dart';

class CashflowDataRespositoryImpl implements CashflowDataRespository {
  @override
  AsyncResult<List<RawCashflowData>> getCashflowDescription() {
    throw UnimplementedError();
  }
}
