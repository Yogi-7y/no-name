import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/iterable_extension.dart';
import '../../../../core/resources/strings.dart';
import '../../../../core/result.dart';
import '../../../../services/internet_service/internet_service.dart';
import '../../../cashflow_publisher/domain/repository/cashflow_publisher_repository.dart';
import '../../../cashflow_source/domain/entity/raw_cashflow_data.dart';
import '../../../cashflow_source/domain/repository/cashflow_source_repository.dart';
import '../entity/cashflow.dart';
import '../repository/cashflow_persistence_repository.dart';
import '../repository/cashflow_transform_repository.dart';

typedef AsyncCashflowResult = AsyncResult<List<Cashflow>>;

class CashflowUseCase {
  const CashflowUseCase({
    required CashflowSourceRespository source,
    required CashflowTransformRepository transformer,
    required CashflowPersistenceRepository persistData,
    required CashflowPublisherRepository publisher,
    required InternetService internetService,
  })  : _source = source,
        _transformer = transformer,
        _persistData = persistData,
        _publisher = publisher,
        _internetService = internetService;

  final CashflowSourceRespository _source;
  final CashflowTransformRepository _transformer;
  final CashflowPersistenceRepository _persistData;
  final CashflowPublisherRepository _publisher;
  final InternetService _internetService;

  Future<Result<void>> call() async {
    try {
      if (!(await _internetService.hasConnection())) {
        if (_source.requireInternetConnection)
          return const Failure(message: Strings.noInternetMessage);

        final _rawCashflow = await _getCashflowFromSource();

        await _persistData.saveCashflow(cashflow: _rawCashflow.valueOrNull ?? []);

        return const Success();
      }

      final _rawCashflowResult = await Future.wait([
        _getCashflowFromSource(),
        _getNotBackedUpCashflow(),
      ]);

      final _combinedRawCashflow = combineRawCashflow(_rawCashflowResult);

      final _cashflowEntry = await convertRawToCashflow(_combinedRawCashflow);

      return const Success();
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return const Failure(message: 'Something went wrong. Please try again later.');
    }
  }

  @visibleForTesting
  List<RawCashflowData> combineRawCashflow(List<Result<List<RawCashflowData>>> data) => data.fold(
        <RawCashflowData>[],
        (previousValue, element) => [
          ...previousValue,
          ...element.valueOrNull ?? [],
        ],
      );

  Future<List<Cashflow>> convertRawToCashflow(List<RawCashflowData> rawData) async {
    final _result = await rawData.asyncMapIndexed(
      (index, element) async {
        final _transformed = await _transformer.transformToCashflowEntry(rawData: element);

        return _transformed;
      },
    );

    final _success = _result.where((element) => element.isSuccess).toList();

    return _success.map((e) => e.valueOrNull!).toList();
  }

  /// Get cashflow from source based on last persistence time.
  AsyncResult<List<RawCashflowData>> _getCashflowFromSource() async {
    final _persistenceState = await _persistData.getLastPersistenceTime();

    if (!_persistenceState.isSuccess)
      return const Failure(message: 'Could not get last persistence time');

    final _result = _persistenceState.valueOrNull;

    if (_result == null) return const Failure(message: 'Could not get last persistence time');

    return _source.getCashflow(
      fromDateTime: _result.lastPersistenceTime,
      toDateTime: DateTime.now(),
    );
  }

  AsyncResult<List<RawCashflowData>> _getNotBackedUpCashflow() async =>
      _persistData.getNotBackedUpCashflow();
}

final cashflowUseCaseProvider = Provider<CashflowUseCase>(
  (ref) => CashflowUseCase(
    source: ref.watch(cashflowSourceRepositoryProvider),
    transformer: ref.watch(cashflowTransformRepositoryProvider),
    persistData: ref.watch(cashflowPersistenceRepositoryProvider),
    internetService: ref.watch(internetServiceProvider),
    publisher: ref.watch(cashflowPublisherProvider),
  ),
);
