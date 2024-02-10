import 'package:flutter/rendering.dart';

import '../../../../core/extensions/date_time_extension.dart';
import '../../../../core/result.dart';
import '../../../../services/internet_service/internet_service.dart';
import '../../domain/entity/raw_cashflow_data.dart';
import '../../domain/repository/cashflow_source_repository.dart';

class CashflowSourceRepositoryImpl implements CashflowRepository {
  const CashflowSourceRepositoryImpl({
    required this.cashflowSource,
    required this.cashflowLocalSource,
    required this.internetService,
  });

  final CashflowSource cashflowSource;
  final CashflowLocalSource cashflowLocalSource;
  final InternetService internetService;

  @override
  AsyncResult<List<RawCashflowData>> getCashflow() async {
    try {
      final _hasConnection = await internetService.hasConnection();
      final _sourceRequireInternetConnection = cashflowSource.requireInternetConnection;

      if (!_sourceRequireInternetConnection) {
        final _lastStoredTime = await cashflowLocalSource.getLastLocalStoreCashflowDateTime();

        final _fromTime = _lastStoredTime.valueOrNull ?? DateTime.now().date;

        final _cashflow = await cashflowSource.getCashflow(
          fromDateTime: _fromTime,
          toDateTime: DateTime.now(),
        );

        await cashflowLocalSource.storeCashflow(cashflow: _cashflow.valueOrNull ?? []);

        await cashflowLocalSource.writeLocalCashflowDataTime(dateTime: DateTime.now());

        return const Success(value: []);
      }

      throw UnimplementedError();
    } catch (e) {
      rethrow;
    }
  }
}
