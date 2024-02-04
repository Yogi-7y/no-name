import 'dart:convert';

import '../../../../core/result.dart';
import '../../../../services/local_state/local_state_service.dart';
import '../../../../services/network/api_client.dart';
import '../../../cashflow_source/domain/entity/raw_cashflow_data.dart';
import '../../../cashflow_transformer/data/repository/gpt/gpt_transformer_request.dart';
import '../../domain/entity/cashflow.dart';
import '../../domain/repository/cashflow_transform_repository.dart';

class GptTransformCashflowRepository implements CashflowTransformRepository {
  const GptTransformCashflowRepository({
    required this.localStateService,
    required this.apiClient,
  });

  final LocalStateService localStateService;
  final ApiClient apiClient;

  @override
  AsyncResult<Cashflow> transformToCashflowEntry({required RawCashflowData rawData}) async {
    final key = await localStateService.readString('openai_api_key');

    if (key == null) return const Failure(message: 'No API key found');

    final _request = GptChatCompletionRequest(
      openAiKey: key,
      prompt: generatePrompt(rawData.content),
    );

    final _response = await apiClient(_request);

    return _response.map((value) {
      final choices = value['choices'] as List<Object?>? ?? <Object?>[];

      final firstChoice = choices[0] as Map<String, Object?>? ?? {};

      final message = firstChoice['message'] as Map<String, Object?>? ?? {};

      final stringifiedContent = message['content'] as String? ?? '';

      final json = jsonDecode(stringifiedContent) as Map<String, Object?>;
      throw UnsupportedError('');

      // return CashflowEntryModel.fromMap(json);
    });
  }
}

String generatePrompt(String data) {
  final prompt = '''
  Input: $data
  Desired Format: Json object with amount, date (in milliseconds), and merchant_name keys & value.

  Json:

''';

  return prompt;
}
