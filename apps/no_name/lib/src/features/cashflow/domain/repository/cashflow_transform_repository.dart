import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/result.dart';
import '../../../../services/local_state/local_state_service.dart';
import '../../../../services/network/api_client.dart';
import '../../../cashflow_source/domain/entity/raw_cashflow_data.dart';
import '../../data/repository/cashflow_transform_repository.dart';
import '../entity/cashflow.dart';

abstract class CashflowTransformRepository {
  AsyncResult<Cashflow> transformToCashflowEntry({
    required RawCashflowData rawData,
  });
}

final cashflowTransformRepositoryProvider = Provider<CashflowTransformRepository>(
  (ref) => GptTransformCashflowRepository(
    localStateService: ref.watch(localStateProvider),
    apiClient: ref.watch(apiClientProvider),
  ),
);
