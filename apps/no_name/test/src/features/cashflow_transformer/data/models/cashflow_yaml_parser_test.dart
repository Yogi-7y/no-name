import 'package:flutter_test/flutter_test.dart';
import 'package:no_name/src/features/cashflow/domain/entity/cashflow.dart';
import 'package:no_name/src/features/cashflow_transformer/data/models/cashflow_yaml_parser.dart';

void main() {
  test(
    'throws FormatException if name is not present',
    () {
      final _yaml = _generateYaml(name: null);

      expect(
        () => CashflowYamlParser.fromYaml(_yaml),
        throwsA(isA<FormatException>()),
      );
    },
  );

  test(
    'throws FormatException if amount is not present',
    () {
      final _yaml = _generateYaml(amount: null);

      expect(
        () => CashflowYamlParser.fromYaml(_yaml),
        throwsA(isA<FormatException>()),
      );

      expect(
        () => CashflowYamlParser.fromYaml(_yaml),
        throwsA(
          predicate<FormatException>(
            (exception) =>
                exception.message.contains('Expected type: num, Got: Null for key: amount'),
          ),
        ),
      );
    },
  );

  test(
    'throws FormatException if amount is of type other than double',
    () {
      final _yaml = _generateYaml(amount: 'hey');

      expect(
        () => CashflowYamlParser.fromYaml(_yaml),
        throwsA(isA<FormatException>()),
      );

      expect(
        () => CashflowYamlParser.fromYaml(_yaml),
        throwsA(
          predicate<FormatException>(
            (exception) =>
                exception.message.contains('Expected type: num, Got: String for key: amount'),
          ),
        ),
      );
    },
  );

  test(
    'throws FormatException if type is not present',
    () {
      final _yaml = _generateYaml(type: null);

      expect(
        () => CashflowYamlParser.fromYaml(_yaml),
        throwsA(isA<FormatException>()),
      );

      expect(
        () => CashflowYamlParser.fromYaml(_yaml),
        throwsA(
          predicate<FormatException>(
            (exception) =>
                exception.message.contains('Expected type: String, Got: Null for key: type'),
          ),
        ),
      );
    },
  );

  test(
    'throws FormatException if date is not present',
    () {
      final _yaml = _generateYaml(date: null);

      expect(
        () => CashflowYamlParser.fromYaml(_yaml),
        throwsA(isA<FormatException>()),
      );

      expect(
        () => CashflowYamlParser.fromYaml(_yaml),
        throwsA(
          predicate<FormatException>(
            (exception) =>
                exception.message.contains('Expected type: int, Got: Null for key: date'),
          ),
        ),
      );
    },
  );

  test(
    'throws FormatException if date is not of type int',
    () {
      final _yaml = _generateYaml(date: '2024-01-01');

      expect(
        () => CashflowYamlParser.fromYaml(_yaml),
        throwsA(isA<FormatException>()),
      );

      expect(
        () => CashflowYamlParser.fromYaml(_yaml),
        throwsA(
          predicate<FormatException>(
            (exception) =>
                exception.message.contains('Expected type: int, Got: String for key: date'),
          ),
        ),
      );

      return null;
    },
  );

  test('yaml serialization', () {
    const yaml = '''
  amount: 973.00
  date: 1643376000000  # Assuming date is in milliseconds since epoch
  merchant_name: Bodyshop
  type: debit
''';

    final _expectedResult = CashflowYamlParser(
      amount: 973,
      dateTime: DateTime.fromMillisecondsSinceEpoch(1643376000000),
      name: 'Bodyshop',
      type: CashflowType.debit,
    );

    final _result = CashflowYamlParser.fromYaml(yaml);

    expect(_result, _expectedResult);
  });
}

String _generateYaml({
  String? name = 'Bodyshop',
  Object? amount = 973,
  String? type = 'debit',
  Object? date = 1643376000000,
}) {
  return '''
  amount: $amount
  date: $date
  merchant_name: $name
  type: $type
''';
}
