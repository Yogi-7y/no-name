import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/local_state/local_state_service.dart';
import '../../../../shared/buttons/async_button.dart';
import '../../../../shared/inputs/app_text_field.dart';
import '../../data/repository/notion/notion_config.dart';

class NotionPublisherScreen extends ConsumerStatefulWidget {
  const NotionPublisherScreen({super.key});

  @override
  ConsumerState<NotionPublisherScreen> createState() => _NotionPublisherScreenState();
}

class _NotionPublisherScreenState extends ConsumerState<NotionPublisherScreen> {
  late final _notionApiTextController = TextEditingController();
  late final _cashflowDatabaseIdTextController = TextEditingController();
  late final _localState = ref.read(localStateProvider);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      unawaited(_fetchDetails());
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _notionApiTextController.dispose();
    super.dispose();
  }

  Future<void> _fetchDetails() async {
    final _data = await _localState.readMap('publisher');

    final _config = NotionConfig.fromMap(_data);

    _notionApiTextController.text = _config.secretKey;
    _cashflowDatabaseIdTextController.text = _config.cashflowDatabaseId;
  }

  Future<void> _save() async {
    final notionApi = _notionApiTextController.text;
    final cashflowDatabaseId = _cashflowDatabaseIdTextController.text;

    final _notionConfig = NotionConfig(
      secretKey: notionApi,
      cashflowDatabaseId: cashflowDatabaseId,
    );

    await _localState.writeMap(
      key: _notionConfig.configType,
      value: _notionConfig.toMap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notion Publisher'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            AppTextField(
              controller: _notionApiTextController,
              labelText: 'Notion API Key',
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _cashflowDatabaseIdTextController,
              labelText: 'Cashflow Database Id',
            ),
            const Spacer(),
            AsyncButton(
              onClick: () async => _save(),
              text: 'Save',
            )
          ],
        ),
      ),
    );
  }
}
