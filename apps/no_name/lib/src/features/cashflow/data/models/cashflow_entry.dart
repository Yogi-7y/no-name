// ignore_for_file: cast_nullable_to_non_nullable

import 'package:flutter/material.dart';

import '../../domain/entity/cashflow_entry.dart';

@immutable
class CashflowEntryModel extends CashflowEntry {
  const CashflowEntryModel({required super.name, required super.amount, required super.dateTime});

  factory CashflowEntryModel.fromMap(Map<String, Object?> map) {
    return CashflowEntryModel(
      name: map['merchant_name'] as String,
      amount: map['amount'] as double,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }
}
