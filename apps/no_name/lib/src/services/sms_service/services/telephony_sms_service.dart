import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

import '../../../core/result.dart';
import '../sms_model.dart';
import '../sms_service.dart';

@immutable
class TelephonySmsService implements SmsService {
  final _instance = Telephony.instance;

  @override
  AsyncResult<List<SmsModel>> getSmsList({
    List<String> senderIds = const [],
    int? startTimeInMilliseconds,
    int? endTimeInMilliseconds,
  }) async {
    final _columns = [
      SmsColumn.ADDRESS,
      SmsColumn.BODY,
      SmsColumn.DATE,
    ];

    SmsFilterStatement filterBase() => SmsFilter.where(SmsColumn.DATE)
        .greaterThanOrEqualTo(startTimeInMilliseconds.toString())
        .and(SmsColumn.DATE)
        .lessThanOrEqualTo(endTimeInMilliseconds.toString())
        .and(SmsColumn.ADDRESS);

    final _sms = <SmsMessage>[];

    for (var i = 0; i < senderIds.length; i++) {
      final _messages = await _instance.getInboxSms(
        columns: _columns,
        filter: filterBase().like('%${senderIds[i]}%'),
        sortOrder: [OrderBy(SmsColumn.DATE)],
      );

      _sms.addAll(_messages);
    }

    final _smsModel = _sms.map((e) => e.toSmsModel()).toList();

    return Success(value: _smsModel);
  }

  @override
  Future<bool> hasPermission() => requestPermission();

  @override
  Future<bool> requestPermission() async {
    final granted = await _instance.requestSmsPermissions;

    return granted ?? false;
  }
}

extension SmsMessageExtension on SmsMessage {
  SmsModel toSmsModel() {
    final _address = address ?? '';
    final _body = body ?? '';
    final _date = date;

    if (_address.isEmpty || _body.isEmpty || _date == null) throw Exception('Invalid SmsMessage');

    return SmsModel(
      senderId: _address,
      message: _body,
      dateTime: DateTime.fromMillisecondsSinceEpoch(_date),
    );
  }
}
