import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/screens/auth/login/login_page.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/home/home_page.dart';
import 'package:reaaia/screens/onBoarding/onBoardingHome.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/TokenUtil.dart';
import 'package:reaaia/utils/onBoardingUtil.dart';
import 'package:reaaia/viewModels/data_provider.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final dataProvider = Provider.of<DataProvider>(context, listen: false);
      await Provider.of<DataProvider>(context, listen: false).getAppData();

      if (dataProvider.appDataModel.status == 200) {
        // TODO: implement again  in last
        await TokenUtil.loadTokenToMemory();
        if (TokenUtil.getTokenFromMemory().isEmpty) {
          await OnBoardingUtil.loadKeyOnBoardingToMemory();
          if (OnBoardingUtil.getKeyOnBoardingFromMemory() == '') {
            CustomFunctions.pushScreenRepcalement(
                widget: OnBoardingHome(), context: context);
          } else {
            CustomFunctions.pushScreenRepcalement(
                widget: LoginPage(), context: context);
          }
        } else {
          CustomFunctions.pushScreenRepcalement(
              widget: HomePage(), context: context);
        }
      } else {
        return;
      }
    });
    // Future.delayed(Duration(seconds: 2), () {
    //   CustomFunctions.pushScreenRepcalement(
    //       widget: OnBoardingHome(), context: context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Stack(
        children: [
          Center(
              child: Image.asset(
            "assets/reaaia_doctor_logo.png",
            scale: 1.8,
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(33)),
              child: Text(
                '@ copyrights to reaaia',
                style: TextStyle(color: ColorsUtils.copyRightsColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
