import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/local_state/local_state_service.dart';
import '../../domain/use_case/cashflow_use_case.dart';

class CashflowScreen extends ConsumerStatefulWidget {
  const CashflowScreen({super.key});

  @override
  ConsumerState<CashflowScreen> createState() => _CashflowScreenState();
}

class _CashflowScreenState extends ConsumerState<CashflowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Cashflow Screen'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final _key = await ref.read(localStateProvider).readString('openai_api_key');
            },
            child: const Text('SMS'),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () async {
              await ref.read(cashflowUseCaseProvider)();
            },
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }
}
