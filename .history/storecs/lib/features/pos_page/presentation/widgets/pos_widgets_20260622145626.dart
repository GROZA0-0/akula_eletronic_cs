import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storecs/Core/styles/Strings.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class PosWidgets extends StatefulWidget {
  const PosWidgets({super.key});

  @override
  State<PosWidgets> createState() => _PosWidgetsState();
}

class _PosWidgetsState extends State<PosWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: Container(
          color: yellow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoSearchTextField(
                decoration: BoxDecoration(
                  color: redColor,
                  border: Border.all(color: white),
                ),
                onTap: () {},
              ),
              Text(POSPage, style: textAppBar),
            ],
          ),
        ),
      ),
    );
  }
}
