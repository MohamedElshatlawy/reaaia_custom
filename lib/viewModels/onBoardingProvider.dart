import 'package:flutter/material.dart';

class OnBoardingIndicatorProvider extends ChangeNotifier {
  PageController pageController = PageController(initialPage: 0);

  void changePage(int page) {
    pageController.animateToPage(page,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
}
