import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/views/auth/signup/request_sent_success.dart';

class SorryScreen extends StatelessWidget {
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
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => RequestSentSuccess()));
              },
              child: Image.asset(
                "assets/sorry.png",
                scale: 1.8,
              ),
            ),
            SizedBox(
              height: 21,
            ),
            Text(
              'We`re sorry',
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
                  'You Account Unfortunately not approved contact With Reaaia Team For More Details',
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
