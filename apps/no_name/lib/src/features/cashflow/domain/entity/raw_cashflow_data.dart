// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class RawCashflowData {
  /// Raw text content most likely from messages, emails describing a transaction.
  final String content;
  const RawCashflowData({
    required this.content,
  });
}
