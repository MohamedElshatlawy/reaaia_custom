import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/homeProvider/navigation_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  void _navigateToPage(int pageIndex) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
    final appNavProvider = context.read<AppNavigationProvider>();
    appNavProvider.pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);
    appNavProvider.navigatorIndex = pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      //padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: BottomNavigationBar(
        currentIndex: context.watch<AppNavigationProvider>().navigatorIndex,
        onTap: (int val) {
          _navigateToPage(val);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsUtils.primaryGreen,
        backgroundColor: Colors.white,
        iconSize: 30.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Reaaia',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Chat',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Care',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Work',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Account',
            backgroundColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}