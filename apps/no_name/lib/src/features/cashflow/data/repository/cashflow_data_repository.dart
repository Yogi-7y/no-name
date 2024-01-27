import 'package:telephony/telephony.dart';

import '../../../../core/result.dart';
import '../../../../services/sms_service/sms_service.dart';
import '../../domain/entity/raw_cashflow_data.dart';
import '../../domain/repository/cashflow_data_repository.dart';

class SmsCashflowRepository implements CashflowDataRespository {
  const SmsCashflowRepository({
    required this.smsService,
  });

  final SmsService smsService;

  @override
  AsyncResult<List<RawCashflowData>> getCashflow() {
    throw UnsupportedError('');
  }
}
