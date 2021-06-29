import 'package:reaaia/utils/Constants.dart';
import 'package:reaaia/utils/PreferenceManger.dart';

class OnBoardingUtil {
  static String _keyOnBoarding='';

  static Future<void> loadKeyOnBoardingToMemory() async {
    _keyOnBoarding = await PreferenceManager.getInstance().getString(Constants.keyOnBoarding);
    print('my Local $_keyOnBoarding}');
  }

  static String getKeyOnBoardingFromMemory() {
    return _keyOnBoarding??'';
  }

  static void saveKeyOnBoarding(String keyOnBoarding) {
    PreferenceManager.getInstance().saveString(Constants.keyOnBoarding, keyOnBoarding);
    //loadKeyOnBoardingToMemory();
  }

  static void clearKeyOnBoarding() {
    PreferenceManager.getInstance().remove(Constants.keyOnBoarding);
    _keyOnBoarding = '';
  }
}