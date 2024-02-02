import '../../../../core/config.dart';

abstract class PublisherConfig extends Config {
  PublisherConfig({
    required super.localStateService,
    required this.publisherName,
  }) : super(key: '${publisherName}_config');

  final String publisherName;
}
