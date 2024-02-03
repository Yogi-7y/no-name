import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'src/app.dart';
import 'src/features/cashflow_source/data/models/raw_cashflow_adapter.dart';
import 'src/services/isar_service.dart';
import 'src/services/local_state/local_state_service.dart';
import 'src/services/network/api_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final _directory = await getApplicationCacheDirectory();
  final _isar = await Isar.open(
    [
      RawCashflowAdapterSchema,
    ],
    directory: _directory.path,
  );

  final _container = ProviderContainer(
    overrides: [
      isarServiceProvider.overrideWithValue(_isar),
    ],
  );

  await _container.read(localStateProvider).init();
  await _container.read(apiClientProvider).setUp();

  runApp(UncontrolledProviderScope(
    container: _container,
    child: const App(),
  ));
}
