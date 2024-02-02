import 'package:flutter/material.dart';

import '../../../../../services/network/request.dart';

const _model = 'gpt-3.5-turbo';

@immutable
class GptChatCompletionRequest extends PostRequest {
  const GptChatCompletionRequest({
    required this.openAiKey,
    required this.prompt,
    super.domain = 'api.openai.com',
    super.path = 'v1/chat/completions',
  });

  final String openAiKey;
  final String prompt;

  @override
  Map<String, Object?> get headers => <String, Object?>{
        'Authorization': 'Bearer $openAiKey',
      };

  @override
  Map<String, Object?> get body => <String, Object?>{
        'model': _model,
        'messages': [
          {
            'role': 'user',
            'content': prompt,
          }
        ],
        'max_tokens': 200,
      };
}
