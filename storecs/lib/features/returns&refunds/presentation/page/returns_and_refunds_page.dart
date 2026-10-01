import 'package:flutter/cupertino.dart';
import 'package:storecs/features/returns&refunds/presentation/widget/returns_and_refunds_widget.dart';

class ReturnsAndRefundsPage extends StatelessWidget {
  final String fullName;
  const ReturnsAndRefundsPage({super.key, required this.fullName});

  @override
  Widget build(BuildContext context) {
    return ReturnsAndRefundsWidget(fullName: fullName);
  }
}
