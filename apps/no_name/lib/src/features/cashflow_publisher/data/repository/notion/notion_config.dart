import '../../../../../core/config.dart';
import '../../../domain/entity/publisher_config.dart';

class NotionConfig extends PublisherConfig {
  NotionConfig({
    required super.localStateService,
    super.publisherName = 'notion',
  });

  @override
  Future<ConfigData> getConfig() {
    throw UnimplementedError();
  }

  @override
  ConfigData onStoreConfig() {
    throw UnimplementedError();
  }
}
