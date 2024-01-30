import 'package:dio/dio.dart';
import 'package:isar/isar.dart';

import '../../domain/entity/raw_cashflow_data.dart';

part 'raw_cashflow_data.g.dart';

@Collection()
@Name('RawCashflow')
class RawCashflowAdapter extends RawCashflowData {
  const RawCashflowAdapter({
    required super.content,
    required super.dateTime,
    this.state = RawCashflowDataState.notBackedUp,
    this.id = Isar.autoIncrement,
  });

  factory RawCashflowAdapter.fromRawCashflowData(RawCashflowData data) => RawCashflowAdapter(
        content: data.content,
        dateTime: data.dateTime,
      );

  final Id id;

  @override
  @Enumerated(EnumType.name)
  // ignore: overridden_fields
  final RawCashflowDataState state;
}
