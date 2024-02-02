import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/result.dart';
import '../../../../services/local_state/local_state_service.dart';
import '../../../../services/network/api_client.dart';
import '../../../cashflow/domain/entity/cashflow.dart';
import '../../../cashflow_source/domain/entity/raw_cashflow_data.dart';
import '../../data/repository/gpt/gpt_transformer.dart';
import '../entity/transformer_config.dart';

abstract class TransformerRepository {
  AsyncResult<Cashflow> transformToCashflow(
    RawCashflowData rawCashflowData, {
    required TransformerConfig config,
  });

  AsyncResult<Iterable<Cashflow>> transformToCashflowList(
    Iterable<RawCashflowData> rawCashflowDataList, {
    required TransformerConfig config,
  });
}

final transformerRepositoryProvider = Provider<TransformerRepository>(
  (ref) => GptTransformer(
    apiClient: ref.read(apiClientProvider),
    localStateService: ref.read(localStateProvider),
  ),
);
