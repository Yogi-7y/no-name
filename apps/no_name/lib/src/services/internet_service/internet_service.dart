import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class InternetService {
  Future<bool> hasConnection();
}

class InternetServiceImpl implements InternetService {
  @override
  Future<bool> hasConnection() async => true;
}

final internetServiceProvider = Provider<InternetService>(
  (ref) => InternetServiceImpl(),
);
