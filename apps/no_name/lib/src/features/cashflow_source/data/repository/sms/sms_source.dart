import '../../../../../core/result.dart';
import '../../../../../services/local_state/local_state_service.dart';
import '../../../../../services/sms_service/sms_service.dart';
import '../../../domain/entity/raw_cashflow_data.dart';
import '../../../domain/repository/cashflow_source_repository.dart';

class SmsSourceRepository implements CashflowSource {
  const SmsSourceRepository({
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
      );

      return _sms.map((value) => value.map(RawCashflowData.fromSms).toList());
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      rethrow;
    }
  }

  @override
  bool get requireInternetConnection => false;

  @override
  AsyncResult<DateTime> getLastLocalStoreCashflowDateTime() {
    throw UnimplementedError();
  }

  @override
  AsyncResult<List<RawCashflowData>> getLocalStoredCashflow() {
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
