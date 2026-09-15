import 'package:flutter/material.dart';
import 'package:storecs/features/settings_page/presentation/widgets/label_scanner_widget.dart';

class LabelScannerPage extends StatefulWidget {
  const LabelScannerPage({super.key});

  @override
  State<LabelScannerPage> createState() => _LabelScannerPageState();
}

class _LabelScannerPageState extends State<LabelScannerPage> {
  @override
  Widget build(BuildContext context) {
    return LabelScannerWidget();
  }
}
