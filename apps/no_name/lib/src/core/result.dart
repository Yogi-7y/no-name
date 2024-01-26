import 'dart:async';

import 'package:flutter/material.dart';

typedef AsyncResult<T> = Future<Result<T>>;

sealed class Result<S> {
  const Result();

  bool get isSuccess => this is Success<S>;

  /// Returns the value if it is [Success] or null otherwise.
  S? get valueOrNull {
    final result = this;

    if (result is Success<S>) return result.value;
    if (result is Failure<S>) return null;

    throw Exception('Invalid Result type ${result.runtimeType}');
  }

  T when<T>({
    required T Function(S value) success,
    required T Function(String message) failure,
  }) {
    final result = this;

    if (result is Success<S>) success(result.value as S);
    if (result is Failure<S>) failure(result.message);

    throw Exception('Invalid Result type ${result.runtimeType}');
  }
}

@immutable
class Success<S> extends Result<S> {
  const Success({this.value});

  final S? value;
}

@immutable
class Failure<S> extends Result<S> {
  const Failure({required this.message});

  final String message;
}
