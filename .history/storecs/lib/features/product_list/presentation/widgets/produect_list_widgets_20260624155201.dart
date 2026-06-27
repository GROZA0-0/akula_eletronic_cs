import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:storecs/Core/styles/Strings.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class ProduectListWidgets extends StatefulWidget {
  const ProduectListWidgets({super.key});

  @override
  State<ProduectListWidgets> createState() => _ProduectListWidgetsState();
}

class _ProduectListWidgetsState extends State<ProduectListWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: Text(ProductListPage, style: textAppBar),
      ),
    );
  }
}
