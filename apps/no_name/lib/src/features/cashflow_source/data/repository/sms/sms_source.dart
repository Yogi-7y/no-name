import '../../../../../core/result.dart';
import '../../../../../services/local_state/local_state_service.dart';
import '../../../../../services/sms_service/sms_service.dart';
import '../../../domain/entity/raw_cashflow_data.dart';
import '../../../domain/repository/cashflow_source_repository.dart';

class SmsSource implements CashflowSource {
  const SmsSource({
    required this.smsService,
    required this.localStateService,
  });

  static const _bankSenderIds = ['HDFCBK', 'ICICIT'];

  final SmsService smsService;
  final LocalStateService localStateService;

  @override
  AsyncResult<List<RawCashflowData>> getCashflow({
    required DateTime fromDateTime,
    required DateTime toDateTime,
  }) async {
    try {
      final _sms = await smsService.getSmsList(
        senderIds: _bankSenderIds,
        startTimeInMilliseconds: fromDateTime.millisecondsSinceEpoch,
        endTimeInMilliseconds: toDateTime.millisecondsSinceEpoch,
      );

      return _sms.map((value) => value.map(RawCashflowData.fromSms).toList());
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      rethrow;
    }
  }

  @override
  bool get requireInternetConnection => false;
}
