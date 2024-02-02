import '../../../../core/result.dart';
import '../../domain/entity/cashflow_entry.dart';
import '../../domain/repository/cashflow_publisher_repository.dart';
import 'requests/notion_publisher_request.dart';

class NotionCashflowPublisherRepository implements CashflowPublisherRepository {
  @override
  AsyncResult<void> publish(List<CashflowEntry> cashflow) {
    throw UnimplementedError();
  }

  AsyncResult<void> _publish(CashflowEntry cashflow) async => throw UnimplementedError();
}
