import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/onBoardingProvider.dart';
import 'package:reaaia/views/onBoarding/index1.dart';
import 'package:reaaia/views/onBoarding/index2.dart';

import 'index3.dart';
import 'index4.dart';

class OnBoardingHome extends StatefulWidget {
  @override
  _OnBoardingHomeState createState() => _OnBoardingHomeState();
}

class _OnBoardingHomeState extends State<OnBoardingHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var onBoardingPageProvider =
        Provider.of<OnBoardingIndicatorProvider>(context);
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: PageView(
        children: [
          Index1(),
          Index2(),
          Index3(),
          Index4(),
        ],
        controller: onBoardingPageProvider.pageController,
      ),
    );
  }
}
