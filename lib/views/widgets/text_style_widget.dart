import 'package:flutter/material.dart';

class TextStyleWidget {
  static TextStyle build({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14,
    Color color = const Color(0xff1e1f20),
    TextDecoration decoration,
  }) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontFamily: "Muli",
      fontStyle: FontStyle.normal,
      fontSize: fontSize,
      decoration: decoration
    );
  }
}
