// ignore_for_file: cast_nullable_to_non_nullable

import 'package:flutter/material.dart';

import '../../domain/entity/cashflow.dart';

@immutable
class CashflowEntryModel extends Cashflow {
  const CashflowEntryModel({
    required super.name,
    required super.amount,
    required super.dateTime,
    required super.type,
  });

  factory CashflowEntryModel.fromMap(Map<String, Object?> map) {
    return CashflowEntryModel(
      name: map['merchant_name'] as String,
      amount: map['amount'] as double,
      type: map['type'] == 'credit' ? CashflowType.credit : CashflowType.debit,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }
}
