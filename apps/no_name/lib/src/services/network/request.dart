import 'package:flutter/material.dart';

@immutable
sealed class Request {
  const Request({
    required this.path,
    this.headers = const {},
    this.queryParameters = const {},
  });

  final String path;
  final Map<String, Object?> headers;
  final Map<String, Object?> queryParameters;

  Uri uri() => Uri();
}

class GetRequest extends Request {
  const GetRequest({
    required super.path,
    super.headers,
    super.queryParameters,
  });
}

class PostRequest extends Request {
  const PostRequest({
    required super.path,
    super.headers,
    super.queryParameters,
    this.body = const {},
  });

  final Map<String, Object?> body;
}
