import '../../../../core/result.dart';
import '../entity/cashflow_entry.dart';
import '../repository/cashflow_transform_repository.dart';
import '../repository/cashflow_source_repository.dart';

typedef AsyncCashflowResult = AsyncResult<List<CashflowEntry>>;

class CashflowUseCase {
  const CashflowUseCase({
    required CashflowSourceRespository cashflowDataRespository,
    required CashflowTransformRepository cashflowConvertorRepository,
  })  : _cashflowDataRespository = cashflowDataRespository,
        _cashflowConvertorRepository = cashflowConvertorRepository;

  final CashflowSourceRespository _cashflowDataRespository;
  final CashflowTransformRepository _cashflowConvertorRepository;

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
