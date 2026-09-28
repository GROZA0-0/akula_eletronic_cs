import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class CustomerDisplayApp extends StatefulWidget {
  final WindowController windowController;
  const CustomerDisplayApp({required this.windowController, super.key});

  @override
  State<CustomerDisplayApp> createState() => _CustomerDisplayAppState();
}

class _CustomerDisplayAppState extends State<CustomerDisplayApp> {
  double currentTotal = 0.0;
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    DesktopMultiWindow.setMethodHandler((call, fromWindowId) async {
      if (call.method == 'customer_display') {
        /*  Decode payload if passed as JSON String, or cast if passed as Map(secondary window) */
        final Map<String, dynamic> data = call.arguments is String
            ? jsonDecode(call.arguments)
            : Map<String, dynamic>.from(call.arguments);

        setState(() {
          currentTotal = (data['totalPrice'] as num?)?.toDouble() ?? 0.0;
          items = (data['items'] as List? ?? [])
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        });

        return 'ok';
      }
      return null;
    });
    /* handler is ready to receive method calls */
    DesktopMultiWindow.invokeMethod(
      0,
      'display_ready',
      widget.windowController.windowId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return customerScreenDetails();
  }

  Widget customerScreenDetails() {
    return Scaffold(
      backgroundColor: invisible,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            sizeBoxHeight(50),
            ScreenTexts(text: 'Customer Order Details', size: 46),
            orderListInformation(),
            sizeBoxHeight(10),
            Divider(color: white),
            sizeBoxHeight(10),
            ScreenTexts(
              text: 'Total: ${currentTotal.toStringAsFixed(2)} JOD',
              size: 43,
            ),
          ],
        ),
      ),
    );
  }

  Widget orderListInformation() {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          final brand =
              item['pBrand'] != null && item['pBrand'].toString().isNotEmpty
              ? '${item['pBrand']} '
              : '';
          final name = item['pName'] ?? '';
          final qty =
              item['quantity'] ?? 1; // Fixed: using quantity instead of pStock
          final price = (item['totalPrice'] as num?)?.toDouble() ?? 0.0;

          return ListTile(
            title: Text(
              '$brand $name',
              style: textBodiesStyle.copyWith(color: white),
            ),
            subtitle: Text(
              'Qty: $qty',
              style: textBodiesStyle.copyWith(color: white),
            ),
            trailing: Text(
              '$price JOD',
              style: textBodiesStyle.copyWith(color: white),
            ),
          );
        },
      ),
    );
  }
}

class ScreenTexts extends StatelessWidget {
  final String text;
  final double? size;
  const ScreenTexts({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textBodiesStyle.copyWith(color: white, fontSize: size),
    );
  }
}
