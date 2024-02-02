import '../../../../core/result.dart';
import '../../../cashflow/domain/entity/cashflow.dart';
import '../../../cashflow_source/domain/entity/raw_cashflow_data.dart';
import '../entity/transformer_config.dart';
import '../repository/transformer_repository.dart';

class TransformerUseCase {
  const TransformerUseCase({
    required this.repository,
  });

  final TransformerRepository repository;

  AsyncResult<Cashflow> transformToCashflow(
    RawCashflowData rawCashflowData, {
    required TransformerConfig config,
  }) =>
      repository.transformToCashflow(rawCashflowData, config: config);
}
