// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class CashflowEntry {
  const CashflowEntry({
    required this.name,
    required this.amount,
    required this.dateTime,
    this.isBackedUp = false,
  });

  final String name;
  final double amount;
  final DateTime dateTime;
  final bool isBackedUp;

  @override
  String toString() =>
      'CashflowEntry(name: $name, amount: $amount, dateTime: $dateTime)';

  @override
  bool operator ==(covariant CashflowEntry other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.amount == amount &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode => name.hashCode ^ amount.hashCode ^ dateTime.hashCode;
}
