import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

/// Local data persistence service
final isarServiceProvider = Provider<Isar>(
  (ref) => throw UnimplementedError(
      'You must provide an implementation of IsarService'),
);
