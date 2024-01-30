import 'package:flutter/material.dart';

@immutable
sealed class Request {
  const Request({
    required this.path,
    required this.domain,
    this.scheme = 'https',
    this.headers = const {},
    this.queryParameters = const {},
  });

  final String path;
  final String scheme;
  final String domain;
  final Map<String, Object?> headers;
  final Map<String, Object?> queryParameters;

  Uri uri();
}

class GetRequest extends Request {
  const GetRequest({
    required super.path,
    required super.domain,
    super.headers,
    super.queryParameters,
  });

  @override
  Uri uri() {
    throw UnimplementedError();
  }
}

class PostRequest extends Request {
  const PostRequest({
    required super.path,
    required super.domain,
    super.headers,
    super.queryParameters,
    super.scheme,
    this.body = const {},
  });

  final Map<String, Object?> body;

  @override
  Uri uri() {
    return Uri(
      path: path,
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      scheme: scheme,
      host: domain,
    );
  }
}
