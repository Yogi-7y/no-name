import '../../../../core/result.dart';
import '../../domain/entity/cashflow_entry.dart';
import '../../domain/repository/cashflow_publisher_repository.dart';

class NotionCashflowPublisherRepository implements CashflowPublisherRepository {
  @override
  AsyncResult<void> publish(List<CashflowEntry> cashflow) {
    throw UnimplementedError();
  }
}
