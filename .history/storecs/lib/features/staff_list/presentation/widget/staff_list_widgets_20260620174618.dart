import 'package:flutter/material.dart';

import 'package:storecs/Core/styles/Strings.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class StaffListWidgets extends StatefulWidget {
  const StaffListWidgets({super.key});

  @override
  State<StaffListWidgets> createState() => _StaffListWidgetsState();
}

class _StaffListWidgetsState extends State<StaffListWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        title: Text(StaffList, style: textAppBar),
      ),
    );
  }
}
