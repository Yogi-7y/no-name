import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/result.dart';
import '../../../cashflow/domain/entity/cashflow.dart';
import '../../data/repository/notion/notion_publisher.dart';

abstract class CashflowPublisherRepository {
  AsyncResult<void> publish(List<Cashflow> cashflow);
}

final cashflowPublisherProvider = Provider<CashflowPublisherRepository>(
  (ref) => NotionPublisher(),
);
