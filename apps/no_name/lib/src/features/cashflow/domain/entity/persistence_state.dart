import 'package:flutter/material.dart';

@immutable
class PersistenceState {
  const PersistenceState({
    required this.lastPersistenceTime,
  });

  final DateTime lastPersistenceTime;
}
