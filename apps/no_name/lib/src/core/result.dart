import 'package:flutter/material.dart';

sealed class Result<S> {
  const Result();

  T when<T>({
    required T Function(S? value) success,
    required T Function(String message) failure,
  }) {
    final result = this;

    if (result is Success<S>) success(result.value);
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
