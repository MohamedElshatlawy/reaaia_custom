import 'package:flutter/material.dart';
import 'package:reaaia/screens/home/care_page.dart';
import 'package:reaaia/screens/home/chat_page.dart';
import 'package:reaaia/screens/home/profile/profile_page.dart';
import 'package:reaaia/screens/home/reaaia_page.dart';
import 'package:reaaia/screens/home/work/work_page.dart';
import 'package:reaaia/screens/widgets/custom_bottom_navbar.dart';

import 'package:reaaia/utils/ColorsUtils.dart';

import 'package:reaaia/viewModels/homeProvider/navigation_provider.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final appNavProvider = context.read<AppNavigationProvider>();
        if (appNavProvider.navigatorIndex == 0) {
          return true;
        } else {
          appNavProvider.pageController.animateToPage(0,
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut);
          appNavProvider.navigatorIndex = 0;
          return false;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:   ColorsUtils.homeBackGroundColor,
        body: PageView(
          controller: context.select<AppNavigationProvider, PageController>(
              (provider) => provider.pageController),
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            ReaaiaPage(),
            ChatPage(),
            CarePage(),
            WorkPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar:  CustomBottomNavBar(),
      ),
    );
  }
}
