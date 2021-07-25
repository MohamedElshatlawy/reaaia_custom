import 'package:flutter/material.dart';

class AppBarWidget {
  final BuildContext context;
  final String title;
  final String icon;
  final Function() onPressed;

  AppBarWidget(
    this.context, {
    this.title = '',
    this.icon = 'BackArrow',
    this.onPressed,
  });

  PreferredSize build() {
    return PreferredSize(
      preferredSize: Size.fromHeight(75), // here the desired height
      child: Padding(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: AppBar(
          elevation: 0,
          bottomOpacity: 0,
          actions: [
            Navigator.of(context).canPop()
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Color(0xff00173d),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: Image.asset('assets/images/search.png'),
                      onPressed: _openSearch,
                    ),
                  ),
            Navigator.of(context).canPop()
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Color(0xff00173d),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: Image.asset('assets/images/calendar.png'),
                      onPressed: _openCalander,
                    ),
                  )
          ],
          backgroundColor: Colors.white,
          leading: icon != '' ? Padding(
            padding: EdgeInsets.only(right: 0),
            child: IconButton(
              icon: Image.asset('assets/images/BackArrow.png'),
              onPressed: _backToPreviousScreen,
            ),
          ) : Container(),
        ),
      ),
    );
  }

  _openCalander() {}
  _openSearch() {}
  _backToPreviousScreen() {
     Navigator.of(context).pop();
  }
}
