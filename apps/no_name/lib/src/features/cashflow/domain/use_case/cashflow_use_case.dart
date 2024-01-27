import '../../../../core/result.dart';
import '../entity/cashflow_entry.dart';
import '../repository/cashflow_convertor_repository.dart';
import '../repository/cashflow_data_repository.dart';

typedef AsyncCashflowResult = AsyncResult<List<CashflowEntry>>;

class CashflowUseCase {
  const CashflowUseCase({
    required CashflowDataRespository cashflowDataRespository,
    required CashflowConvertorRepository cashflowConvertorRepository,
  })  : _cashflowDataRespository = cashflowDataRespository,
        _cashflowConvertorRepository = cashflowConvertorRepository;

  final CashflowDataRespository _cashflowDataRespository;
  final CashflowConvertorRepository _cashflowConvertorRepository;

  AsyncCashflowResult getCashflow() async {
    final rawData = await _cashflowDataRespository.getCashflow();

    return rawData.when(
      success: (rawData) {
        print(rawData);
        return Success();
      },
      failure: (message) => Failure(message: message),
    );
  }
}
