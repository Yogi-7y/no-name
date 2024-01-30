import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shared_preference_service.dart';

abstract class LocalStateService {
  Future<void> init();

  Future<void> writeString({
    required String key,
    required String value,
  });

  Future<String?> readString(String key);
}

final localStateProvider = Provider<LocalStateService>((ref) => SharedPreferenceService());
