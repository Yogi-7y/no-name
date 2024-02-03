import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef AsyncOrCallback<T> = FutureOr<T> Function();

class AsyncButton<T> extends StatefulWidget {
  const AsyncButton({
    required this.onClick,
    required this.text,
    super.key,
  });

  final AsyncOrCallback<T> onClick;
  final String text;

  @override
  State<AsyncButton<T>> createState() => _AsyncButtonState<T>();
}

class _AsyncButtonState<T> extends State<AsyncButton<T>> {
  bool _isLoading = false;

  Future<void> _onClick() async {
    try {
      if (_isLoading) return;

      _isLoading = true;
      setState(() {});

      await widget.onClick();
    } finally {
      _isLoading = false;

      setState(() {});
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: _isLoading ? 0 : 1,
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
