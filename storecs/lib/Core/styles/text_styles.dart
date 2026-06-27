import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storecs/Core/Styles/Colors.dart';

final textAppBar = GoogleFonts.aleo(
  fontSize: 30,
  color: white,
  fontWeight: FontWeight.w400,
);
final textBodiesStyle = GoogleFonts.aleo(
  color: white,
  fontWeight: FontWeight.w400,
);
final textBodiesStyle2 = GoogleFonts.aleo(
  color: redColor,
  fontWeight: FontWeight.w400,
);

TextStyle textStyleForButtons(double fontSize) {
  return GoogleFonts.aleo(
    color: white,
    fontWeight: FontWeight.w400,
    fontSize: fontSize,
  );
}

Widget textDrawerStyle(String text) {
  return ShaderMask(
    shaderCallback: (bounds) => LinearGradient(
      colors: [deepViolet, amethyst, lavenderGray],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(bounds),
    child: Text(text, style: textBodiesStyle),
  );
}
