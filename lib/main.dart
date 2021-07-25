import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:reaaia/screens/splash.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/FontsUtils.dart';
import 'package:reaaia/viewModels/data_provider.dart';
import 'package:reaaia/viewModels/homeProvider/navigation_provider.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';
import 'package:reaaia/viewModels/locale/localizationProvider.dart';
import 'package:reaaia/viewModels/login_provider.dart';
import 'package:reaaia/viewModels/onBoardingProvider.dart';
import 'package:reaaia/viewModels/phoneCode_provider.dart';
import 'package:reaaia/viewModels/sign_up_provider.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: OnBoardingIndicatorProvider()),
      ChangeNotifierProvider.value(value: LocalProvider()),
      ChangeNotifierProvider.value(value: PhoneCodeProvider()),
      ChangeNotifierProvider.value(value: LoginProvider()),
      ChangeNotifierProvider.value(value: DataProvider()),
      ChangeNotifierProvider.value(value: AppNavigationProvider()),
      ChangeNotifierProvider.value(value: ClinicsProvider()),
      ChangeNotifierProvider.value(value: SignUpProvider()),
    ],
    child: MyMaterial(),
  ));
}

class MyMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locProvider = Provider.of<LocalProvider>(context);
final localeLanguage = Platform.localeName; 
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        //locale: locProvider.appLocal,
        locale: Locale('ar'),
        theme: ThemeData(
            primaryColor: ColorsUtils.primaryGreen,
            fontFamily: FontUtils.MULI_FONT),
        supportedLocales: 
        localeLanguage == 'ar_EG' ? 
        [
          Locale('ar', ''),
        ]
        : [
           Locale('en', 'US'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback:
         (local, supportedLocals) {
          for(var supportedLocal in supportedLocals) {
            if (supportedLocal.languageCode == local.languageCode
            &&
            supportedLocal.countryCode == local.countryCode
            ) {
                return supportedLocal;
            }
          }
          return supportedLocals.first;
        },
        home: Splash(),
      ),
    );
  }
}
