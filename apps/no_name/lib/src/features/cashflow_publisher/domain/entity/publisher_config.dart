import '../../../../core/config.dart';

abstract class PublisherConfig extends Config {
  PublisherConfig({
    required this.publisherName,
    this.configType = 'publisher',
  }) : super(key: '${publisherName}_config');

  final String publisherName;

  final String configType;
}
