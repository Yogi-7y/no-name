import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cashflow_source/presentation/captured_cashflow.dart';
import '../widgets/app_navigation_drawer.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _CashflowScreenState();
}

class _CashflowScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late final _tabBarController = TabController(length: 2, vsync: this);
  late final _pageController = PageController(initialPage: _tabBarController.index);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cashflow'),
        bottom: TabBar(
          controller: _tabBarController,
          tabs: const [
            Tab(text: 'Captured'),
            Tab(text: 'Processed'),
          ],
        ),
      ),
      drawer: const AppNavigationDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          _tabBarController.animateTo(value);
        },
        children: [
          CapturedCashflow(),
          ProcessedCashflow(),
        ],
      ),
    );
  }
}

class ProcessedCashflow extends StatelessWidget {
  const ProcessedCashflow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Processed');
  }
}
