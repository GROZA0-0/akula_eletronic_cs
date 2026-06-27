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
              placeholderStyle: textBodiesStyle,
              style: textBodiesStyle,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: white),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: screenSize,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: white),
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.030,
                horizontal: size.width * 0.008,
              ),
              child: Row(
                children: [
                  /* Cart section */
                  Container(
                    width: size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: white),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Add customer button
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.add, size: 16),
                                label: Text('Add Customer'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.orange,
                                  side: BorderSide(color: Colors.orange),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.grid_view),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.refresh),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        /* CategoryTabs(),ProductsGrid() */
                        Expanded(child: Column(children: [
                      ],
                    )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
