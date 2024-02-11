import 'package:flutter_test/flutter_test.dart';
import 'package:no_name/src/core/extensions/date_time_extension.dart';

void main() {
  test(
    'When date it today should return Today',
    () {
      final _date = DateTime.now();
      const _expected = 'Today';

      final _result = _date.formattedDate;

      expect(_result, _expected);
    },
  );

  test(
    'When date is of yesterday, should return Yesterday',
    () {
      final _date = DateTime.now().subtract(const Duration(days: 1));
      const _expected = 'Yesterday';

      final _result = _date.formattedDate;

      expect(_result, _expected);
    },
  );

  group(
    'when date is within the last 7 days',
    () {
      final _sourceDate = DateTime(2024, 2, 11);

      test(
        'should return Friday',
        () {
          final _date = _sourceDate.subtract(const Duration(days: 2));
          const _expected = 'Friday';

          final _result = _date.formattedDate;

          expect(_result, _expected);
        },
      );

      test(
        'should return Thursday',
        () {
          final _date = _sourceDate.subtract(const Duration(days: 3));
          const _expected = 'Thursday';

          final _result = _date.formattedDate;

          expect(_result, _expected);
        },
      );

      test('should return Monday', () {
        final _date = _sourceDate.subtract(const Duration(days: 6));
        const _expected = 'Monday';

        final _result = _date.formattedDate;

        expect(_result, _expected);
      });
    },
  );

  group(
    'When date is past more than 7 days',
    () {
      test(
        'should return 1st Jan, 2024',
        () {
          final _date = DateTime(2024);
          const _expected = '1st Jan, 2024';

          final _result = _date.formattedDate;

          expect(_result, _expected);
        },
      );

      test(
        'should return 2nd Jan, 2024',
        () {
          final _date = DateTime(2024, 1, 2);
          const _expected = '2nd Jan, 2024';

          final _result = _date.formattedDate;

          expect(_result, _expected);
        },
      );

      test(
        'should return 3rd Jan, 2024',
        () {
          final _date = DateTime(2024, 1, 3);
          const _expected = '3rd Jan, 2024';

          final _result = _date.formattedDate;

          expect(_result, _expected);
        },
      );

      test(
        'should return 4th Jan, 2024',
        () {
          final _date = DateTime(2024, 1, 4);
          const _expected = '4th Jan, 2024';

          final _result = _date.formattedDate;

          expect(_result, _expected);
        },
      );
    },
  );
}
