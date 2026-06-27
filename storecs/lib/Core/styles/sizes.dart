import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

final size = MediaQuery.of(navigator!.context).size;

Widget sizeBox(double sized) {
  return SizedBox(height: size.height * sized);
}

Widget sizeBoxHeight(double sizeHeight) {
  return SizedBox(height: sizeHeight);
}

Widget sizeBoxWidth(double sizeWidth) {
  return SizedBox(width: sizeWidth);
}

final screenSize = EdgeInsets.symmetric(
  horizontal: size.width * 0.02,
  vertical: size.width * 0.01,
);
