import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/cashflow/presentation/screens/dashboard_screen.dart';
import '../../features/cashflow_publisher/presentation/publishers/notion_publisher_screen.dart';
import '../../features/cashflow_publisher/presentation/screens/publisher_screen.dart';
import '../../features/cashflow_transformer/presentation/screens/transformer_screen.dart';
import '../../features/cashflow_transformer/presentation/transformers/gpt_transformer_screen.dart';

enum AppRoutes {
  dashboard('/'),
  publisher('publishers'),
  notionPublisher('notion'),
  transformer('transformer'),
  gptTransformer('gpt');

  const AppRoutes(this.path);

  final String path;
}

final goRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: AppRoutes.dashboard.path,
    routes: [
      GoRoute(
        path: AppRoutes.dashboard.path,
        name: AppRoutes.dashboard.name,
        builder: (context, state) => const DashboardScreen(),
        routes: [
          GoRoute(
            path: AppRoutes.publisher.path,
            name: AppRoutes.publisher.name,
            builder: (context, state) => const PublisherScreen(),
            routes: [
              GoRoute(
                path: AppRoutes.notionPublisher.path,
                name: AppRoutes.notionPublisher.name,
                builder: (context, state) => const NotionPublisherScreen(),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.transformer.path,
            name: AppRoutes.transformer.name,
            builder: (context, state) => const TransformerScreen(),
            routes: [
              GoRoute(
                path: AppRoutes.gptTransformer.path,
                name: AppRoutes.gptTransformer.name,
                builder: (context, state) => const GptTransformerScreen(),
              ),
            ],
          )
        ],
      ),
    ],
  ),
);
