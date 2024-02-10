import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart';

class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Publisher'),
            onTap: () => context.goNamed(AppRoutes.publisher.name),
          ),
          ListTile(
            title: const Text('Transformer'),
            onTap: () => context.goNamed(AppRoutes.transformer.name),
          ),
        ],
      ),
    );
  }
}
