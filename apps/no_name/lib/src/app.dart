import 'package:flutter/material.dart';

import 'features/cashflow/presentation/screens/cashflow_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CashflowScreen(),
    );
  }
}
