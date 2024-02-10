import 'dart:convert';

import '../../../../../core/result.dart';
import '../../../../../services/local_state/local_state_service.dart';
import '../../../../../services/network/api_client.dart';
import '../../../../cashflow/domain/entity/cashflow.dart';
import '../../../../cashflow_source/domain/entity/raw_cashflow_data.dart';
import '../../../domain/entity/transformer_config.dart';
import '../../../domain/repository/transformer_repository.dart';
import '../../models/cashflow_yaml_parser.dart';
import 'gpt_config.dart';
import 'gpt_transformer_request.dart';

class GptTransformer implements TransformerRepository {
  const GptTransformer({
    required this.apiClient,
    required this.localStateService,
  });

  final ApiClient apiClient;
  final LocalStateService localStateService;

  @override
  AsyncResult<Cashflow> transformToCashflow(
    RawCashflowData rawCashflowData, {
    required TransformerConfig config,
  }) async {
    if (config is! GptConfig) return const Failure(message: 'Invalid config');

    final key = config.openAiApiKey;

    if (key.isEmpty) return const Failure(message: 'No API key found');

    final _request = GptChatCompletionRequest(
      openAiKey: key,
      prompt: generatePrompt(rawCashflowData.content),
    );

    final _response = await apiClient(_request);

    return _response.map((value) {
      final choices = value['choices'] as List<Object?>? ?? <Object?>[];

      final firstChoice = choices[0] as Map<String, Object?>? ?? {};

      final message = firstChoice['message'] as Map<String, Object?>? ?? {};

      final content = message['content'] as String? ?? '';

      return CashflowYamlParser.fromYaml(content);
    });
  }

  @override
  AsyncResult<Iterable<Cashflow>> transformToCashflowList(
    Iterable<RawCashflowData> rawCashflowDataList, {
    required TransformerConfig config,
  }) async {
    throw UnimplementedError();
  }

  String generatePrompt(String data) {
    final prompt = '''
  Input: $data
  Desired Format: Yaml format with amount, date (in milliseconds), type(credit/debit) and merchant_name. null if missing.

  YAML:
''';

    return prompt;
  }
}
