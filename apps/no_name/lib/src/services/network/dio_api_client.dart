import 'package:dio/dio.dart';

import '../../core/result.dart';
import 'api_client.dart';
import 'request.dart';

class DioApiClient implements ApiClient {
  late final Dio _dio;

  @override
  Future<void> setUp() async {
    final _baseOptions = BaseOptions();

    _dio = Dio(_baseOptions);
  }

  @override
  ApiResponse call<T>(Request request) async {
    if (request is GetRequest)
      return Success(value: await _handleGetRequest(request));

    if (request is PostRequest)
      return Success(value: await _handlePostRequest(request));

    throw UnsupportedError('Unsupported request type ${request.runtimeType}');
  }

  Future<Map<String, Object?>> _handleGetRequest(
    GetRequest request,
  ) async {
    final _response = await _dio.getUri<Map<String, Object?>?>(request.uri());
    return _response.data ?? {};
  }

  Future<Map<String, Object?>> _handlePostRequest(
    PostRequest request,
  ) async {
    final _response = await _dio.postUri<Map<String, Object?>?>(
      request.uri(),
      data: request.body,
    );
    return _response.data ?? {};
  }
}
