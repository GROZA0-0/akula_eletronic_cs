import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarCodeScannerListener extends StatefulWidget {
  final void Function(String scannedCode) onScan;
  final Widget child;
  const BarCodeScannerListener({
    super.key,
    required this.onScan,
    required this.child,
  });

  @override
  State<BarCodeScannerListener> createState() => _BarCodeScannerListenerState();
}

class _BarCodeScannerListenerState extends State<BarCodeScannerListener> {
  String _buffer = '';
  DateTime? lastKeyTime;

  void handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    final now = DateTime.now();

    // if too much time passed since last key, treat as a new sequence (likely human typing)
    if (lastKeyTime != null &&
        now.difference(lastKeyTime!).inMilliseconds > 50) {
      _buffer = '';
    }
    lastKeyTime = now;

    if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (_buffer.length > 3) {
        // scanners produce a full code fast; ignore accidental single Enter presses
        widget.onScan(_buffer);
      }
      _buffer = '';
      /* the code checks if the key has a readable text character representation  */
    } else if (event.character != null) {
      _buffer += event.character!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      autofocus: true,
      onKeyEvent: handleKey,
      child: widget.child,
    );
  }
}
