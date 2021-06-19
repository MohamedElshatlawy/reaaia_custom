import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:reaaia/utils/ColorsUtils.dart';

class RequestSentSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 124,
            ),
            Image.asset(
              "assets/success.png",
              scale: 1.8,
            ),
            SizedBox(
              height: 21,
            ),
            Text(
              'Request Sent Successful',
              style: TextStyle(
                  color: ColorsUtils.primaryGreen,
                  fontWeight: FontWeight.w800,
                  fontSize: ScreenUtil().setSp(24)),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                  'Wait Within 2-3 Business Days For Our Medical Expert To Check And Confirm',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorsUtils.onBoardingTextGrey,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: ScreenUtil().setSp(15),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
