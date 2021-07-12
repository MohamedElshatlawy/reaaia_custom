import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:intl/intl.dart';
import 'package:reaaia/utils/ColorsUtils.dart';

class CustomRoundedButton extends StatelessWidget {
  String text;
  Function pressed;
  Color backgroundColor;
  Color textColor;
  Color borderColor;
  Icon icon;
  double width;
  double height;
  bool iconLeft;
  CustomRoundedButton({
    this.pressed,
    this.text,
    this.backgroundColor,
    this.borderColor,
    this.icon,
    this.textColor,
    this.width,
    this.iconLeft=false,
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderColor??ColorsUtils.primaryGreen)),
        color: backgroundColor,
        onPressed: pressed ?? () {},
        child:iconLeft? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            (icon == null) ? Container() : icon,
            SizedBox(width: ScreenUtil().setWidth(10),),
            Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                  fontSize: ScreenUtil().setSp(15)),
            ),

          ],
        ):Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                  fontSize: ScreenUtil().setSp(15)),
            ),
            SizedBox(width: ScreenUtil().setWidth(10),),
            (icon == null) ? Container() : icon
          ],
        ),
      ),
    );
  }
}
