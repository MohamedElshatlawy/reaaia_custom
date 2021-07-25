import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/screens/onBoarding/tasks_for_today_boarding.dart';
import 'package:reaaia/screens/onBoarding/private_care_services_boarding.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/onBoardingProvider.dart';


import 'private_lab_results_boarding.dart';
import 'track_your_medication_boarding.dart';

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
          TasksForTodayOnBoarding(),
          PrivateCareServicesOnBoarding(),
          PrivateLabResultsOnBoarding(),
          TrackYourMedicationOnBoarding(),
        ],
        controller: onBoardingPageProvider.pageController,
      ),
    );
  }
}
