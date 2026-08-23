import 'package:flutter/material.dart';
import 'package:storecs/features/pos_page/presentation/widgets/pos_widgets.dart';

class PosPage extends StatelessWidget {
  final String fullName;
  const PosPage({super.key, required this.fullName});

  @override
  Widget build(BuildContext context) {
    return PosWidgets(fullName: fullName);
  }
}
