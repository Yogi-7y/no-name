import '../../../domain/entity/publisher_config.dart';

const _secretKeyName = 'notion_secret';
const _cashflowDatabaseIdKey = 'notion_cashflow_database_id';

class NotionConfig extends PublisherConfig {
  NotionConfig({
    required this.secretKey,
    required this.cashflowDatabaseId,
    super.publisherName = 'notion',
  });

  final String secretKey;
  final String cashflowDatabaseId;

  @override
  Map<String, Object?> onToMap() => {
        _secretKeyName: secretKey,
        _cashflowDatabaseIdKey: cashflowDatabaseId,
      };

  factory NotionConfig.fromMap(Map<String, dynamic> map) => NotionConfig(
        secretKey: map[_secretKeyName] as String? ?? '',
        cashflowDatabaseId: map[_cashflowDatabaseIdKey] as String? ?? '',
      );
}
