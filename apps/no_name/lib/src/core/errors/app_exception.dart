// ignore_for_file: sort_constructors_first

import 'package:flutter/material.dart';

import '../result.dart';

@immutable
class AppException implements Exception {
  const AppException({
    required this.message,
    this.stackTrace,
    this.exception,
  });

  final String message;
  final StackTrace? stackTrace;
  final Object? exception;

  factory AppException.fromFailure(Failure<Object?> failure) {
    return AppException(
      message: failure.message,
      stackTrace: failure.stackTrace,
      exception: failure.exception,
    );
  }
}
