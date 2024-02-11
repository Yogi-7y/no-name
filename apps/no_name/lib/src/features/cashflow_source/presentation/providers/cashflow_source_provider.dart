import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/result.dart';
import '../../domain/entity/raw_cashflow_data.dart';
import '../../domain/use_case/cashflow_source_use_case.dart';

class CashflowSourceNotifier extends AsyncNotifier<List<RawCashflowData>> {
  @override
  FutureOr<List<RawCashflowData>> build() async {
    final _useCase = ref.watch(cashflowSourceUseCaseProvider);

    final _result = await _useCase.getCashflow();

    return _result.when(
      success: (value) => value,
      failure: (message) => throw AppException.fromFailure(_result as Failure),
    );
  }
}

final cashflowSourceProvider = AsyncNotifierProvider<CashflowSourceNotifier, List<RawCashflowData>>(
  CashflowSourceNotifier.new,
);
