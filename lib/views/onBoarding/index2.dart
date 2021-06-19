import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/onBoardingProvider.dart';
import 'package:reaaia/views/auth/login/login.dart';

import '../customFunctions.dart';

class Index2 extends StatelessWidget {
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
                    onBoardingPageProvider.changePage(0);
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
                    CustomFunctions.pushScreen(
                        context: context, widget: Login());
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                        color: ColorsUtils.onBoardingTextGrey,
                        fontSize: ScreenUtil().setSp(17),
                        fontWeight: FontWeight.w700),
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
              'assets/onBoarding/onboard_index2.png',
              height: ScreenUtil().setHeight(289),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(104)),
          new DotsIndicator(
              dotsCount: 4,
              decorator: DotsDecorator(
                  activeColor: ColorsUtils.blueColor, color: Colors.grey[200]),
              position: 1.0),
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
                      'Private Care Services',
                      style: TextStyle(
                          color: ColorsUtils.blueColor,
                          fontSize: ScreenUtil().setSp(22),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  'Book an online in-person',
                  style: TextStyle(
                      color: ColorsUtils.onBoardingTextGrey,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'appointment with a Doctor',
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