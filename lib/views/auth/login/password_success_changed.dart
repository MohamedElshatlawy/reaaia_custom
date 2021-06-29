import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/views/auth/login/login.dart';

import '../../customFunctions.dart';

class PasswordSuccessChanged extends StatefulWidget {
  @override
  _PasswordSuccessChangedState createState() => _PasswordSuccessChangedState();
}

class _PasswordSuccessChangedState extends State<PasswordSuccessChanged> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      CustomFunctions.pushScreenRepcalement(
          widget: Login(), context: context);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 185,
            ),
            Image.asset(
              "assets/img_success.png",
              scale: 1.8,
            ),
            SizedBox(
              height: 21,
            ),
            Text(
              'Congrats!',
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
                'successfully change password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorsUtils.onBoardingTextGrey,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: ScreenUtil().setSp(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
