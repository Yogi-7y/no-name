import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import '../../../../core/validator.dart';
import '../../../cashflow/domain/entity/cashflow.dart';

@immutable
class CashflowYamlParser extends Cashflow {
  const CashflowYamlParser({
    required super.name,
    required super.amount,
    required super.type,
    required super.dateTime,
  });

  factory CashflowYamlParser.fromYaml(String yaml) {
    final _data = loadYaml(yaml) as YamlMap?;
    if (_data == null) throw FormatException('Invalid yaml: $yaml');

    ValidatorCallback<T> _validator<T>() => createValidatorFor<T, YamlMap>(_data);

    final _name = _validator<String>()('merchant_name');
    final _amount = _validator<num>()('amount');
    final _type = _validator<String>()('type');
    final _dateTimeInMilliseconds = _validator<int>()('date');

    final _dateTime = DateTime.fromMillisecondsSinceEpoch(_dateTimeInMilliseconds);
    return CashflowYamlParser(
      name: _name,
      amount: _amount.toDouble(),
      type: CashflowType.fromString(_type),
      dateTime: _dateTime,
    );
  }
}
