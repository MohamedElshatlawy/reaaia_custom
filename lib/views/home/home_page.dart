import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/TokenUtil.dart';
import 'package:reaaia/viewModels/homeProvider/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';
import 'package:reaaia/views/home/account_page.dart';
import 'package:reaaia/views/home/care_page.dart';
import 'package:reaaia/views/home/chat_page.dart';
import 'package:reaaia/views/home/reaaia_page.dart';
import 'file:///C:/Users/ahmed/AndroidStudioProjects/reaaia_custom/lib/views/home/work/work_page.dart';
import 'package:reaaia/views/widgets/custom_bottom_navbar.dart';

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
            AccountPage(),
          ],
        ),
        bottomNavigationBar:  CustomBottomNavBar(),
      ),
    );
  }
}
