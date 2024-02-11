import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:no_name/src/core/extensions/date_time_extension.dart';
import 'package:no_name/src/core/result.dart';
import 'package:no_name/src/features/cashflow_source/data/repository/cashflow_source_repository.dart';
import 'package:no_name/src/features/cashflow_source/domain/repository/cashflow_source_repository.dart';
import 'package:no_name/src/services/internet_service/internet_service.dart';

/// Flow:
/// 1. User opens the app and does not have internet.
/// 2. sms source is the selected source which does not require internet.
/// 3. sms source fetches the cashflow data from the sms service.
/// 4. sms source stores the cashflow data locally.
/// 5. sms source logs the time so in future the source can be queries only for items post the last log time.
/// 6. sms source returns the combined cashflow data from local storage and the fetched data.
/// 7. No further process as internet is not available.
/// 8. User opens the app again after sometime and now has internet.
/// 9. sms source is queried to return cashflow data from the last log time.
/// 10. combines the data from the sms service and local storage and returns the data and returns it.
/// 11. Logs the time of the last cashflow data fetched.
/// 12. The data is passed to the transformer layer.
/// 13. Transformer converts the raw data to the required format.
/// 14. In case of any error, the raw data is stored locally and status is updated to error during parsing.
/// 15. If successfully parsed, data is passed to the publisher layer.
/// 16. Publisher publishes the data to the selected publishing service to back it up.
/// 17. In case of any error, the data is stored locally and status is updated to error during publishing.
/// 18. If successfully published, the data is cleared from the local storage.
/// 19. The transformed data is stored locally.

class MockInternetService extends Mock implements InternetService {}

class MockCashflowLocalSource extends Mock implements CashflowLocalSource {}

class MockCashflowSource extends Mock implements CashflowSource {}

void main() {
  late MockInternetService mockInternetService;
  late MockCashflowLocalSource mockCashflowLocalSource;
  late MockCashflowSource mockCashflowSource;

  late CashflowSourceRepositoryImpl systemUserTest;

  setUp(() async {
    mockInternetService = MockInternetService();
    mockCashflowLocalSource = MockCashflowLocalSource();
    mockCashflowSource = MockCashflowSource();
    systemUserTest = CashflowSourceRepositoryImpl(
      cashflowSource: mockCashflowSource,
      internetService: mockInternetService,
      cashflowLocalSource: mockCashflowLocalSource,
    );

    when(() => mockInternetService.hasConnection()).thenAnswer((_) async => true);
    when(() => mockCashflowSource.requireInternetConnection).thenReturn(false);

    when(() => mockCashflowSource.getCashflow(
          fromDateTime: any(named: 'fromDateTime'),
          toDateTime: any(named: 'toDateTime'),
        )).thenAnswer((_) async => const Success(value: []));

    when(() => mockCashflowLocalSource.getCashflow())
        .thenAnswer((_) async => const Success(value: []));

    when(() => mockCashflowLocalSource.writeLocalCashflowDataTime(dateTime: any(named: 'dateTime')))
        .thenAnswer((_) async => const Success());

    when(() => mockCashflowLocalSource.storeCashflow(cashflow: any(named: 'cashflow')))
        .thenAnswer((_) async => const Success());

    final _lastStoredTime = DateTime.now().subtract(const Duration(days: 1));
    when(
      () => mockCashflowLocalSource.getLastLocalStoreCashflowDateTime(),
    ).thenAnswer((_) async => Success(value: _lastStoredTime));
  });

  test(
    'Ensure last stored time is being passed in as fromTime while fetching from source.',
    () async {
      final _lastStoredTime = DateTime.now().subtract(const Duration(days: 1));
      when(
        () => mockCashflowLocalSource.getLastLocalStoreCashflowDateTime(),
      ).thenAnswer((_) async => Success(value: _lastStoredTime));
      await systemUserTest.getCashflow();

      verify(
        () => mockCashflowLocalSource.getLastLocalStoreCashflowDateTime(),
      ).called(1);

      verify(
        () => mockCashflowSource.getCashflow(
          fromDateTime: _lastStoredTime,
          toDateTime: any(named: 'toDateTime'),
        ),
      ).called(1);
    },
  );

  test(
    'When last stored time is not present, take fromTime from today 00:00',
    () async {
      when(
        () => mockCashflowLocalSource.getLastLocalStoreCashflowDateTime(),
      ).thenAnswer((_) async => const Success());

      await systemUserTest.getCashflow();

      verify(
        () => mockCashflowSource.getCashflow(
          fromDateTime: DateTime.now().date,
          toDateTime: any(named: 'toDateTime'),
        ),
      ).called(1);
    },
  );

  test(
    'When no internet, fetch raw cashflow data from sms source and store it locally & log the time',
    () async {
      when(() => mockInternetService.hasConnection()).thenAnswer((_) async => false);

      await systemUserTest.getCashflow();

      verifyInOrder([
        () => mockCashflowSource.getCashflow(
            fromDateTime: any(named: 'fromDateTime'), toDateTime: any(named: 'toDateTime')),
        () => mockCashflowLocalSource.storeCashflow(cashflow: any(named: 'cashflow')),
        () => mockCashflowLocalSource.writeLocalCashflowDataTime(dateTime: any(named: 'dateTime')),
      ]);
    },
  );
}
