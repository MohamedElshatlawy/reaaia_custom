import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:reaaia/screens/auth/login/login.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/onBoardingUtil.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';



class Index1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsUtils.greyColor,
      child: Column(
        children: [
          SizedBox(height: ScreenUtil().setHeight(50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  OnBoardingUtil.saveKeyOnBoarding('isBoarding');
                  CustomFunctions.pushScreenRepcalement(context: context, widget: Login());
                },
                child: Text(
                  AppLocalizations.of(context).translate('skipBoarding'),
                  style: TextStyle(
                      color: ColorsUtils.onBoardingTextGrey,
                      fontSize: ScreenUtil().setSp(17),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: ScreenUtil().setWidth(20)),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(35)),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12.5)),
            child: Image.asset(
              'assets/onBoarding/onboard_index1.png',
              height: ScreenUtil().setHeight(289),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(104)),
          new DotsIndicator(
              dotsCount: 4,
              decorator: DotsDecorator(
                  activeColor: ColorsUtils.blueColor, color: Colors.grey[200]),
              position: 0.0),
          SizedBox(height: ScreenUtil().setHeight(43)),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(45.5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('onBoardingText1'),
                      style: TextStyle(
                          color: ColorsUtils.blueColor,
                          fontSize: ScreenUtil().setSp(22),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  AppLocalizations.of(context).translate('onBoardingText2'),
                  style: TextStyle(
                      color: ColorsUtils.onBoardingTextGrey,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  AppLocalizations.of(context).translate('onBoardingText3'),
                  style: TextStyle(
                      color: ColorsUtils.onBoardingTextGrey,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
