import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart';

class TransformerScreen extends ConsumerWidget {
  const TransformerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transformers'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('GPT'),
            onTap: () => context.goNamed(AppRoutes.gptTransformer.name),
          )
        ],
      ),
    );
  }
}
