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

    final _filter = senderIds.isEmpty
        ? null
        : createFilter(
            senderIds,
            SmsFilter.where(SmsColumn.ADDRESS),
          );

    final _sms = await _instance.getInboxSms(
      columns: _columns,
      filter: _filter,
      sortOrder: [OrderBy(SmsColumn.DATE)],
    );

    final _smsModel = _sms.map((e) => e.toSmsModel()).toList();

    return Success(value: _smsModel);
  }

  SmsFilter createFilter(List<String> value, SmsFilterStatement statement) {
    if (value.isEmpty) throw Exception('value cannot be empty');

    if (value.length == 1) return statement.like('%${value.first}%');

    final _removedItem = value.removeLast();

    return createFilter(
      value,
      statement.like('%$_removedItem%').or(SmsColumn.ADDRESS),
    );
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

    if (_address.isEmpty || _body.isEmpty || _date == null)
      throw Exception('Invalid SmsMessage');

    return SmsModel(
      senderId: _address,
      message: _body,
      dateTime: DateTime.fromMillisecondsSinceEpoch(_date),
    );
  }
}
