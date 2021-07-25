import 'package:flutter/material.dart';
import 'text_style_widget.dart';

class FlatButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Widget icon;
  const FlatButtonWidget({
    @required this.text,
    @required this.onPressed,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 15,
    this.color = const Color(0xff3dc4c4),
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        icon,
        SizedBox(width: 15.0),
          Text(text,
              style: TextStyleWidget.build(
                  fontWeight: fontWeight,
                  color:
                      color == Colors.white ? Color(0xff4a4a4a) : Colors.white,
                  fontSize: fontSize),
              textAlign: TextAlign.center),
        ],
      ),
      color: color,
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(
            width: 1,
            color: Color(color == Colors.white ? 0xffc6c6c6 : 0xff3a856d),
            style: BorderStyle.none),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
