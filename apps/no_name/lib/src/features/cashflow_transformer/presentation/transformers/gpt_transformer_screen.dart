import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/local_state/local_state_service.dart';
import '../../../../shared/buttons/async_button.dart';
import '../../../../shared/inputs/app_text_field.dart';
import '../../data/repository/gpt/gpt_config.dart';

class GptTransformerScreen extends ConsumerStatefulWidget {
  const GptTransformerScreen({super.key});

  @override
  ConsumerState<GptTransformerScreen> createState() => _GptTransformerScreenState();
}

class _GptTransformerScreenState extends ConsumerState<GptTransformerScreen> {
  late final _openAiApiKeyTextController = TextEditingController();
  late final _localState = ref.read(localStateProvider);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      unawaited(_fetchDetails());
    });
  }

  Future<void> _fetchDetails() async {
    final _data = await _localState.readMap('transformer');

    final _config = GptConfig.fromMap(_data);

    _openAiApiKeyTextController.text = _config.openAiApiKey;
  }

  Future<void> _save() async {
    final openAiApiKey = _openAiApiKeyTextController.text;

    final _config = GptConfig(openAiApiKey: openAiApiKey);

    await _localState.writeMap(key: 'transformer', value: _config.toMap());
  }

  @override
  void dispose() {
    _openAiApiKeyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPT Transformer'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            AppTextField(
              controller: _openAiApiKeyTextController,
              labelText: 'OpenAI API Key',
            ),
            const Spacer(),
            AsyncButton(
              onClick: _save,
              text: 'Save',
            ),
          ],
        ),
      ),
    );
  }
}
