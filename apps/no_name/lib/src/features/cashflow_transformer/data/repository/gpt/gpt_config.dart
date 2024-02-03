import '../../../domain/entity/transformer_config.dart';

const _openAiApiKeyName = 'openAiApiKey';

class GptConfig extends TransformerConfig {
  GptConfig({
    required this.openAiApiKey,
    super.transformerName = 'gpt',
  });

  final String openAiApiKey;

  @override
  Map<String, Object?> onToMap() => {
        _openAiApiKeyName: openAiApiKey,
      };

  factory GptConfig.fromMap(Map<String, dynamic> map) => GptConfig(
        openAiApiKey: map[_openAiApiKeyName] as String? ?? '',
      );
}
