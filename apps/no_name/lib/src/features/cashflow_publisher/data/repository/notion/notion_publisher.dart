import '../../../../../core/result.dart';
import '../../../../cashflow/domain/entity/cashflow.dart';
import '../../../domain/repository/cashflow_publisher_repository.dart';

class NotionPublisher implements CashflowPublisherRepository {
  @override
  AsyncResult<void> publish(List<Cashflow> cashflow) {
    throw UnimplementedError();
  }
}
