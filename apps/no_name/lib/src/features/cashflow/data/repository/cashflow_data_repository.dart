import '../../../../core/result.dart';
import '../../../../services/sms_service/sms_service.dart';
import '../../domain/entity/raw_cashflow_data.dart';
import '../../domain/repository/cashflow_source_repository.dart';

class SmsCashflowRepository implements CashflowSourceRespository {
  const SmsCashflowRepository({
    required this.smsService,
  });

  static const _bankSenderIds = ['HDFCBK'];

  final SmsService smsService;

  @override
  AsyncResult<List<RawCashflowData>> getCashflow({
    required DateTime fromDateTime,
    required DateTime toDateTime,
  }) async {
    final _sms = await smsService.getSmsList(
      senderIds: _bankSenderIds,
    );

    return _sms.map((value) => value.map(RawCashflowData.fromSms).toList());
  }

  @override
  bool get requireInternetConnection => false;
}
