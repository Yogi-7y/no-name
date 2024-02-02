import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:no_name/src/core/resources/Strings.dart';
import 'package:no_name/src/core/result.dart';
import 'package:no_name/src/features/cashflow/domain/entity/cashflow.dart';
import 'package:no_name/src/features/cashflow/domain/entity/persistence_state.dart';
import 'package:no_name/src/features/cashflow/domain/entity/raw_cashflow_data.dart';
import 'package:no_name/src/features/cashflow/domain/repository/cashflow_persistence_repository.dart';
import 'package:no_name/src/features/cashflow_publisher/domain/repository/cashflow_publisher_repository.dart';
import 'package:no_name/src/features/cashflow_source/domain/repository/cashflow_source_repository.dart';
import 'package:no_name/src/features/cashflow/domain/repository/cashflow_transform_repository.dart';
import 'package:no_name/src/features/cashflow/domain/use_case/cashflow_use_case.dart';
import 'package:no_name/src/services/internet_service/internet_service.dart';

class MockSourceRepository extends Mock implements CashflowSourceRespository {}

class MockTransformRepository extends Mock implements CashflowTransformRepository {}

class MockPersistenceRepository extends Mock implements CashflowPersistenceRepository {}

class MockPublisherRepository extends Mock implements CashflowPublisherRepository {}

class MockInternetService extends Mock implements InternetService {}

void main() {
  late CashflowUseCase _useCase;
  late MockSourceRepository _sourceRepository;
  late MockTransformRepository _transformRepository;
  late MockPersistenceRepository _persistenceRepository;
  late MockPublisherRepository _publisherRepository;
  late MockInternetService _internetService;

  setUp(
    () {
      _sourceRepository = MockSourceRepository();
      _transformRepository = MockTransformRepository();
      _persistenceRepository = MockPersistenceRepository();
      _publisherRepository = MockPublisherRepository();
      _internetService = MockInternetService();

      _useCase = CashflowUseCase(
        source: _sourceRepository,
        transformer: _transformRepository,
        persistData: _persistenceRepository,
        publisher: _publisherRepository,
        internetService: _internetService,
      );
    },
  );

  test('verify cashflow is fetched from source and local database when internet is available',
      () async {
    when(() => _internetService.hasConnection()).thenAnswer((_) async => true);

    when(
      () => _sourceRepository.getCashflow(
        fromDateTime: any(named: 'fromDateTime'),
        toDateTime: any(named: 'toDateTime'),
      ),
    ).thenAnswer((_) async => const Success());

    when(
      () => _persistenceRepository.getLastPersistenceTime(),
    ).thenAnswer(
      (invocation) async => Success(
        value: PersistenceState(lastPersistenceTime: DateTime.now()),
      ),
    );

    when(() => _persistenceRepository.getNotBackedUpCashflow())
        .thenAnswer((_) async => const Success(value: []));

    when(() => _persistenceRepository.getNotBackedUpCashflow())
        .thenAnswer((_) async => const Success(value: []));

    await _useCase();

    verify(
      () => _sourceRepository.getCashflow(
        fromDateTime: any(named: 'fromDateTime'),
        toDateTime: any(named: 'toDateTime'),
      ),
    ).called(1);

    verify(
      () => _persistenceRepository.getNotBackedUpCashflow(),
    ).called(1);
  });

  test(
    'return Failure if internet is not available and source requires internet to work',
    () async {
      when(() => _internetService.hasConnection()).thenAnswer((_) async => false);

      when(() => _sourceRepository.requireInternetConnection).thenReturn(true);

      final _result = await _useCase();

      expect(
        _result,
        predicate(
          (p0) => _result is Failure && _result.message == Strings.noInternetMessage,
        ),
      );
    },
  );

  test(
    "when internet is not available and source doesn't require internet to work, fetch data and store it locally",
    () async {
      when(
        () => _internetService.hasConnection(),
      ).thenAnswer((invocation) async => false);

      when(() => _sourceRepository.requireInternetConnection).thenReturn(false);

      when(
        () => _persistenceRepository.getLastPersistenceTime(),
      ).thenAnswer((invocation) async =>
          Success(value: PersistenceState(lastPersistenceTime: DateTime.now())));

      when(
        () => _sourceRepository.getCashflow(
            fromDateTime: any(named: 'fromDateTime'), toDateTime: any(named: 'toDateTime')),
      ).thenAnswer((invocation) async => const Success(value: []));

      when(
        () => _persistenceRepository.saveCashflow(cashflow: any(named: 'cashflow')),
      ).thenAnswer((invocation) async => const Success());

      await _useCase();

      verify(
        () => _sourceRepository.getCashflow(
          fromDateTime: any(named: 'fromDateTime'),
          toDateTime: any(named: 'toDateTime'),
        ),
      ).called(1);

      verify(
        () => _persistenceRepository.saveCashflow(cashflow: any(named: 'cashflow')),
      ).called(1);
    },
  );

  group(
    'combineRawCashflow',
    () {
      test('return empty list if input is empty', () {
        final _result = _useCase.combineRawCashflow([]);

        expect(_result, isEmpty);
      });

      test(
        'return combined list if all the inputs are success',
        () {
          final _resultOne = Success(value: [
            RawCashflowData(
              content: '_resultOne success one',
              dateTime: DateTime.now(),
            ),
            RawCashflowData(
              content: '_resultOne success two',
              dateTime: DateTime.now(),
            ),
          ]);

          final _resultTwo = Success(value: [
            RawCashflowData(
              content: '_resultTwo success one',
              dateTime: DateTime.now(),
            ),
          ]);

          final _result = _useCase.combineRawCashflow([_resultOne, _resultTwo]);

          expect(_result, hasLength(3));
          expect(
            _result,
            predicate<List<RawCashflowData>>((item) =>
                item.any((element) => element.content == '_resultOne success one') &&
                item.any((element) => element.content == '_resultTwo success one')),
          );
        },
      );

      test(
        'return list from success result and omit out failure',
        () {
          final _success = Success(value: [
            RawCashflowData(
              content: '_resultOne success one',
              dateTime: DateTime.now(),
            ),
            RawCashflowData(
              content: '_resultOne success two',
              dateTime: DateTime.now(),
            ),
          ]);

          const _failure = Failure<List<RawCashflowData>>(message: '');

          final _result = _useCase.combineRawCashflow([_success, _failure]);

          expect(_result, hasLength(2));
          expect(
            _result,
            predicate<List<RawCashflowData>>(
              (item) => item.every((element) => element.content.contains('_resultOne')),
            ),
          );
        },
      );
    },
  );
}
