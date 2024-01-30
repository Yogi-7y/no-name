// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../services/sms_service/sms_model.dart';

enum RawCashflowDataState {
  /// The data is backed up to the cloud.
  backedUp,

  /// The data is not backed up to the cloud.
  notBackedUp,

  /// The data was not backed up to the cloud because of an error.
  failed,
}

@immutable
class RawCashflowData {
  /// Raw text content most likely from messages, emails describing a transaction.
  final String content;
  final RawCashflowDataState state;
  final DateTime dateTime;

  const RawCashflowData({
    required this.content,
    required this.dateTime,
    this.state = RawCashflowDataState.notBackedUp,
  });

  factory RawCashflowData.fromSms(SmsModel sms) => RawCashflowData(
        content: sms.message,
        dateTime: sms.dateTime,
      );
}
