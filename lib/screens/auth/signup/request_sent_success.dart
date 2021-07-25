import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/screens/auth/signup/congrats.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';

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
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => Congrats()));
              },
              child: Image.asset(
                "assets/success.png",
                scale: 0.5,
              ),
            ),
            SizedBox(
              height: 21,
            ),
            Text(
              AppLocalizations.of(context).translate('reqSent1'),
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
                  AppLocalizations.of(context).translate('reqSent2'),
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
