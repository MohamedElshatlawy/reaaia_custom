import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class CustomRoundedButton extends StatelessWidget {
  String text;
  Function pressed;
  Color backgroundColor;
  Color textColor;
  Color borderColor;
  Icon icon;
  CustomRoundedButton({
    this.pressed,
    this.text,
    this.backgroundColor,
    this.borderColor,
    this.icon,
    this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderColor)),
        color: backgroundColor,
        onPressed: pressed ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                  fontSize: ScreenUtil().setSp(15)),
            ),
            (icon == null) ? Container() : icon
          ],
        ),
      ),
    );
  }
}
