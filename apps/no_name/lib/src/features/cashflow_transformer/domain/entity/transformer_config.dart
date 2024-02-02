import 'package:flutter/foundation.dart';

import '../../../../core/config.dart';

abstract class TransformerConfig extends Config {
  TransformerConfig({
    required super.localStateService,
    required this.transformerName,
  }) : super(
          key: '${transitionTextConfiguration}_config',
        );

  final String transformerName;
}
