import '../../../../core/result.dart';
import '../../../../services/sms_service/sms_service.dart';
import '../../domain/entity/raw_cashflow_data.dart';
import '../../domain/repository/cashflow_source_repository.dart';

class SmsCashflowRepository implements CashflowSourceRespository {
  const SmsCashflowRepository({
    required this.smsService,
  });

  final SmsService smsService;

  @override
  AsyncResult<List<RawCashflowData>> getCashflow() {
    throw UnsupportedError('');
  }
}
