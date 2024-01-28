import '../../../../core/result.dart';
import '../../domain/entity/cashflow_entry.dart';
import '../../domain/repository/cashflow_source_repository.dart';

class CashflowPersistenceRepositoryImpl
    implements CashflowPersistenceRepository {
  @override
  AsyncResult<void> saveCashflow({
    required List<CashflowEntry> cashflow,
  }) {
    throw UnimplementedError();
  }
}
