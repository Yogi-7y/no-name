import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/result.dart';
import 'dio_api_client.dart';
import 'request.dart';

typedef ApiResponse = Future<Result<Map<String, Object?>>>;

abstract class ApiClient {
  Future<void> setUp();

  ApiResponse call(Request request);
}

final apiClientProvider = Provider<ApiClient>((ref) => DioApiClient());
