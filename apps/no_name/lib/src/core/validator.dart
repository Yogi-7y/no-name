T validate<T, S extends Map<Object?, Object?>>(
  String key,
  S source,
) {
  final _value = source[key];

  final _stringBuffer = StringBuffer();

  if (_value is! T) {
    _stringBuffer
      ..writeln('Expected type: $T, Got: ${_value.runtimeType} for key: $key')
      ..writeln('Source: $source');
    throw FormatException(_stringBuffer.toString());
  }

  return _value;
}

typedef ValidatorCallback<T> = T Function(String key);

ValidatorCallback<T> createValidatorFor<T, S extends Map<Object?, Object?>>(
  S source,
) =>
    (key) => validate<T, S>(
          key,
          source,
        );
