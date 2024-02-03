import '../../../domain/entity/transformer_config.dart';

class GptConfig extends TransformerConfig {
  GptConfig({
    required this.openAiApiKey,
    super.transformerName = 'gpt',
  });

  final String openAiApiKey;

  @override
  Map<String, Object?> onToMap() => {
        'openAiApiKey': openAiApiKey,
      };
}
