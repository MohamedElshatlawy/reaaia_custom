import 'package:flutter/material.dart';
import 'package:reaaia/singleton/SettingsSession.dart';
import 'package:reaaia/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale("en");
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(Constants.languageCode) == null) {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.getString(Constants.languageCode));
    notifyListeners();
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ar")) {
      _appLocale = Locale("ar");
      await prefs.setString(Constants.languageCode, 'ar');
      await prefs.setString(Constants.countryCode, '');
    } else {
      _appLocale = Locale("en");
      await prefs.setString(Constants.languageCode, 'en');
      await prefs.setString(Constants.countryCode, 'US');
    }
    SettingsSession.instance().loadLanguage();
    notifyListeners();
  }
}
