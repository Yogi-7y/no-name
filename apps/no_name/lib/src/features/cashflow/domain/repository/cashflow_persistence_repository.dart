import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/result.dart';
import '../../../../services/isar_service.dart';
import '../../../cashflow_source/domain/entity/raw_cashflow_data.dart';
import '../../data/repository/cashflow_persistence_repository.dart';
import '../entity/persistence_state.dart';

/// Responsible to store the raw cashflow data to the local database \
/// and other persistence related tasks related to cashflow.
@immutable
abstract class CashflowPersistenceRepository {
  AsyncResult<void> saveCashflow({
    required List<RawCashflowData> cashflow,
  });

  AsyncResult<List<RawCashflowData>> getBackedUpCashflow();

  AsyncResult<List<RawCashflowData>> getNotBackedUpCashflow();

  AsyncResult<void> logPersistenceTime();

  AsyncResult<PersistenceState> getLastPersistenceTime();
}

final cashflowPersistenceRepositoryProvider = Provider<CashflowPersistenceRepository>(
  (ref) => IsarCashflowPersistenceRepository(isar: ref.watch(isarServiceProvider)),
);
