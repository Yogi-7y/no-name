// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class SmsModel {
  const SmsModel({
    required this.senderId,
    required this.message,
    required this.dateTime,
  });

  final String senderId;
  final String message;
  final DateTime dateTime;

  @override
  String toString() =>
      'SmsModel(senderId: $senderId, message: $message, dateTime: $dateTime)';

  @override
  bool operator ==(covariant SmsModel other) {
    if (identical(this, other)) return true;

    return other.senderId == senderId &&
        other.message == message &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode => senderId.hashCode ^ message.hashCode ^ dateTime.hashCode;
}
