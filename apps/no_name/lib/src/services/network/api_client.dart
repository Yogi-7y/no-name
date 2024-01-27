import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/result.dart';
import 'request.dart';

typedef ApiResponse = Future<Result<Map<String, Object?>>>;

abstract class ApiClient {
  Future<void> setUp();

  ApiResponse call<T>(Request request);
}

final apiClientProvider = Provider<ApiClient>(
    (ref) => throw UnimplementedError('apiClientProvider is not implemented'));
