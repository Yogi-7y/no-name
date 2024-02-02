import '../../../../../core/config.dart';
import '../../../domain/entity/transformer_config.dart';

class GptConfig extends TransformerConfig {
  GptConfig({
    required super.localStateService,
  }) : super(transformerName: 'gpt');

  @override
  Future<ConfigData> getConfig() {
    throw UnimplementedError();
  }

  @override
  ConfigData onStoreConfig() {
    throw UnimplementedError();
  }

  Future<String?> getOpenAiKey() async {
    final config = await getConfig();
    return config['openai_api_key'] as String?;
  }
}
