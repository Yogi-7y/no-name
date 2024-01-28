import 'package:flutter/material.dart';

import '../../../../core/result.dart';
import '../entity/cashflow_entry.dart';
import '../entity/raw_cashflow_data.dart';

@immutable
abstract class CashflowSourceRespository {
  AsyncResult<List<RawCashflowData>> getCashflow();
}

@immutable
abstract class CashflowPersistenceRepository {
  AsyncResult<void> saveCashflow({
    required List<RawCashflowData> cashflow,
  });

  AsyncResult<List<CashflowEntry>> getBackedUpCashflow();

  AsyncResult<List<CashflowEntry>> getNotBackedUpCashflow();
}
