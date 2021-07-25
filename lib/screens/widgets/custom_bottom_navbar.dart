import 'package:flutter/material.dart';
import 'package:reaaia/screens/widgets/reaaia__icons_icons.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/homeProvider/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';

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
            icon: Icon(Reaaia_Icons.reaaia_icon),
            label: AppLocalizations.of(context).translate('reaaia'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Reaaia_Icons.chat_icon),
            label: AppLocalizations.of(context).translate('chat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Reaaia_Icons.icon),
            label: AppLocalizations.of(context).translate('care'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Reaaia_Icons.work_icon),
            label: AppLocalizations.of(context).translate('work'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Reaaia_Icons.account_icon),
            label: AppLocalizations.of(context).translate('account'),
          ),
        ],
      ),
    );
  }
}
