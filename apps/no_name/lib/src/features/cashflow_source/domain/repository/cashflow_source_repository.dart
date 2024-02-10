import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/result.dart';
import '../../../../services/sms_service/sms_service.dart';
import '../../data/repository/sms/sms_source.dart';
import '../entity/raw_cashflow_data.dart';

/// Source to fetch cashflow data from.\
/// This could be from an SMS, email a web service, etc.
abstract class CashflowSource {
  bool get requireInternetConnection;

  AsyncResult<List<RawCashflowData>> getCashflow({
    required DateTime fromDateTime,
    required DateTime toDateTime,
  });
}

/// Local source to store and retrieve cashflow data from.\
/// This could be from a local database, file, etc.
abstract class CashflowLocalSource {
  AsyncResult<List<RawCashflowData>> getCashflow();

  AsyncResult<void> storeCashflow({
    required List<RawCashflowData> cashflow,
  });

  AsyncResult<void> writeLocalCashflowDataTime({
    required DateTime dateTime,
  });

  AsyncResult<DateTime> getLastLocalStoreCashflowDateTime();
}

/// Manages cashflow data fetched from source and is responsible
/// for storing and retrieving cashflow data from local storage, depending
/// on different conditions such as internet connection, etc.
@immutable
abstract class CashflowRepository {
  AsyncResult<List<RawCashflowData>> getCashflow();
}
