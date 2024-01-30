import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/result.dart';
import 'services/telephony_sms_service.dart';
import 'sms_model.dart';

abstract class SmsService {
  AsyncResult<List<SmsModel>> getSmsList({
    /// only return sms that has senderId in this list
    List<String> senderIds,

    /// only return sms that are sent after this time.
    int? startTimeInMilliseconds,

    /// only return sms that are sent before this time.
    /// If null, it will return sms that are sent before now
    int? endTimeInMilliseconds,
  });

  Future<bool> hasPermission();

  Future<bool> requestPermission();
}

final smsServiceProvider = Provider<SmsService>((ref) => TelephonySmsService());
