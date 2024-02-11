import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/app_exception.dart';
import 'providers/cashflow_source_provider.dart';

class CapturedCashflow extends ConsumerWidget {
  const CapturedCashflow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(cashflowSourceProvider).when(
          data: (source) => ListView.separated(
            itemCount: source.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final _cashflow = source[index];

              return ListTile(
                title: Text(_cashflow.formattedDateTime),
                subtitle: Text(_cashflow.content),
              );
            },
          ),
          error: (error, __) {
            if (error is AppException) return Center(child: Text(error.message));

            return Text('error $error');
          },
          loading: () => const Text('loading'),
        );
  }
}
