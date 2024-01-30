import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/result.dart';
import '../../data/repository/cashflow_publisher_repository.dart';
import '../entity/cashflow_entry.dart';

abstract class CashflowPublisherRepository {
  AsyncResult<void> publish(List<CashflowEntry> cashflow);
}

final cashflowPublisherProvider = Provider<CashflowPublisherRepository>(
  (ref) => NotionCashflowPublisherRepository(),
);
