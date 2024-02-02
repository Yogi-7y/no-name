import 'package:meta/meta.dart';

import '../services/local_state/local_state_service.dart';

typedef ConfigData = Map<String, Object?>;

abstract class Config {
  const Config({
    required this.localStateService,
    required this.key,
  });

  final LocalStateService localStateService;
  final String key;

  /// Returns the config that needs to be stored in the local state
  @protected
  ConfigData onStoreConfig();

  Future<void> storeConfig({
    required ConfigData config,
  }) =>
      localStateService.writeMap(
        key: key,
        value: onStoreConfig(),
      );

  Future<ConfigData> getConfig();
}
