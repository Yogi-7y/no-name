import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/result.dart';
import '../entity/raw_cashflow_data.dart';
import '../repository/cashflow_source_repository.dart';

class CashflowSourceUseCase {
  CashflowSourceUseCase(this._repository);

  final CashflowRepository _repository;

  AsyncResult<List<RawCashflowData>> getCashflow() => _repository.getCashflow();
}

final cashflowSourceUseCaseProvider = Provider(
  (ref) => CashflowSourceUseCase(ref.watch(cashflowRepository)),
);
