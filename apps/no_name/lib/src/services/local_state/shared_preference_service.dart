import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'local_state_service.dart';

class SharedPreferenceService implements LocalStateService {
  late final SharedPreferences _sharedPreferences;
  @override
  Future<void> init() async => _sharedPreferences = await SharedPreferences.getInstance();

  @override
  Future<String?> readString(String key) async => _sharedPreferences.getString(key);

  @override
  Future<void> writeString({required String key, required String value}) =>
      _sharedPreferences.setString(key, value);

  @override
  Future<Map<String, Object?>> readMap(String key) async {
    final _data = _sharedPreferences.getString(key);
    if (_data == null) return {};

    final _jsonDecode = jsonDecode(_data) as Map<String, Object?>? ?? {};

    return _jsonDecode;
  }

  @override
  Future<void> writeMap({
    required String key,
    required Map<String, Object?> value,
  }) {
    final _jsonEncode = jsonEncode(value);

    return _sharedPreferences.setString(key, _jsonEncode);
  }
}
