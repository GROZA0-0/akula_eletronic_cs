import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:storecs/Core/styles/colors.dart';

double widthOfButton = MediaQuery.of(navigator!.context).size.width;

class Alerts {
  final GlobalKey<ScaffoldMessengerState> messengerKey;
  Alerts(this.messengerKey);
  ifErrors(String e) => messengerKey.currentState?.showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.down,
      width: widthOfButton / 1.3 + 20,
      behavior: SnackBarBehavior.floating,
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.error_outline, color: redColor),
          Text(e, style: const TextStyle(color: redColor)),
          const Text(
            '.',
            style: TextStyle(color: Colors.transparent, fontSize: 1),
          ),
        ],
      ),
    ),
  );

  ifSuccess(String e) => messengerKey.currentState?.showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.down,
      width: widthOfButton / 1.3 + 20,
      behavior: SnackBarBehavior.floating,
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.lightbulb, color: greenColor),
          Text(e, style: const TextStyle(color: greenColor)),
          const Text(
            '.',
            style: TextStyle(color: Colors.transparent, fontSize: 1),
          ),
        ],
      ),
    ),
  );
}
