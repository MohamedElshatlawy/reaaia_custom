import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/screens/auth/login/login_page.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/onBoardingUtil.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';
import 'package:reaaia/viewModels/onBoardingProvider.dart';

import '../customFunctions.dart';

class TrackYourMedicationOnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var onBoardingPageProvider =
        Provider.of<OnBoardingIndicatorProvider>(context);
    return Container(
      color: ColorsUtils.greyColor,
      child: Column(
        children: [
          SizedBox(height: ScreenUtil().setHeight(50)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    onBoardingPageProvider.changePage(2);
                  },
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(
                        Icons.arrow_back,
                        color: ColorsUtils.blueColor,
                      )),
                ),
                InkWell(
                  onTap: () {
                    OnBoardingUtil.saveKeyOnBoarding('isBoarding');
                    CustomFunctions.pushScreenRepcalement(
                        context: context, widget: LoginPage());
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('skipBoarding'),
                    style: TextStyle(
                        color: ColorsUtils.onBoardingTextGrey,
                        fontSize: ScreenUtil().setSp(17),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(35)),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12.5)),
            child: Image.asset(
              'assets/onBoarding/onboard_index4.png',
              height: ScreenUtil().setHeight(289),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(104)),
          new DotsIndicator(
              dotsCount: 4,
              decorator: DotsDecorator(
                  activeColor: ColorsUtils.blueColor, color: Colors.grey[200]),
              position: 3.0),
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
                      AppLocalizations.of(context).translate('onBoardingText9'),
                      style: TextStyle(
                          color: ColorsUtils.blueColor,
                          fontSize: ScreenUtil().setSp(22),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  AppLocalizations.of(context).translate('onBoardingText10'),
                  style: TextStyle(
                      color: ColorsUtils.onBoardingTextGrey,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
