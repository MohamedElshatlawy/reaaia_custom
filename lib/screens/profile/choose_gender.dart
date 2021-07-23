import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChooseGender extends StatelessWidget {
  final String iconName;
  final String genderName;
  final Color iconColor;
  final Color textColor;
  final Color backgroundColor;
  final Function onTap;

  ChooseGender(
      {this.iconName,
      this.genderName,
      this.iconColor,
      this.textColor,
      this.onTap,
      this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            Container(
              width: ScreenUtil().setWidth(45),
              height: ScreenUtil().setHeight(45),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(15)),
              child: SvgPicture.asset(
                iconName,
                color: iconColor,
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
            Text(
              genderName,
              style: TextStyle(
                  color: textColor,
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
