import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/onBoardingUtil.dart';
import 'package:reaaia/viewModels/data_provider.dart';
import 'package:reaaia/views/auth/login/login.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/home/home_page.dart';
import 'package:reaaia/views/onBoarding/onBoardingHome.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DataProvider>(context, listen: false).getAppData().then(
          (value) async{
            // TODO: implement again  in last
            // await  OnBoardingUtil.loadKeyOnBoardingToMemory();
            // if(OnBoardingUtil.getKeyOnBoardingFromMemory()==''){
            //   CustomFunctions.pushScreenRepcalement(
            //       widget: OnBoardingHome(), context: context);
            // }else{
            //   CustomFunctions.pushScreenRepcalement(
            //       widget: HomePage(), context: context);
            // }
            CustomFunctions.pushScreenRepcalement(
                widget: HomePage(), context: context);

          });
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
