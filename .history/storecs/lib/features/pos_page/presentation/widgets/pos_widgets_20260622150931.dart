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
        title: Text(POSPage, style: textAppBar),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.13,
              vertical: size.width * 0.0011,
            ),
            // color: yellow,
            width: size.width / 3,
            child: CupertinoSearchTextField(
              cursorColor: white,
              itemColor: white,
              placeholder: 'Search Product',
              style: TextStyle(color: white),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: white),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
