import 'package:meta/meta.dart';

typedef ConfigData = Map<String, Object?>;

abstract class Config {
  const Config({
    required this.key,
  });

  final String key;

  @protected
  Map<String, Object?> onToMap();

  Map<String, Object?> toMap() => {
        'key': key,
        ...onToMap(),
      };
}
