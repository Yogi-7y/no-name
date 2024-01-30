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
}
