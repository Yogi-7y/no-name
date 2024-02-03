import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart';

class PublisherScreen extends ConsumerWidget {
  const PublisherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publishers'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Notion'),
            onTap: () => context.goNamed(AppRoutes.notionPublisher.name),
          )
        ],
      ),
    );
  }
}
