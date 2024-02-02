import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/result.dart';
import '../../../../services/sms_service/sms_service.dart';
import '../../data/repository/cashflow_data_repository.dart';
import '../entity/raw_cashflow_data.dart';

@immutable
abstract class CashflowSourceRespository {
  AsyncResult<List<RawCashflowData>> getCashflow({
    required DateTime fromDateTime,
    required DateTime toDateTime,
  });

  /// Whether the repository requires an internet connection to work.
  bool get requireInternetConnection;
}

final cashflowSourceRepositoryProvider = Provider<CashflowSourceRespository>(
  (ref) => SmsCashflowRepository(smsService: ref.watch(smsServiceProvider)),
);