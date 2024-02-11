import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime get date => DateTime(year, month, day);

  String get formattedDate {
    final _now = DateTime.now().date;
    final _date = date;

    if (_now == _date) return 'Today';

    if (_now.subtract(const Duration(days: 1)) == _date) return 'Yesterday';

    if (_now.difference(_date).inDays < 7) return DateFormat('EEEE').format(this);

    return '${DateFormat('d').format(this)}${_getDaySuffix(DateFormat('d').format(this))} ${DateFormat('MMM, yyyy').format(this)}';
  }

  String _getDaySuffix(String date) {
    final _date = int.parse(date);
    if (_date == 1) return 'st';
    if (_date == 2) return 'nd';
    if (_date == 3) return 'rd';
    return 'th';
  }
}
