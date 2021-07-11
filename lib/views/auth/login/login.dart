import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/utils/TokenUtil.dart';
import 'package:reaaia/viewModels/login_provider.dart';
import 'package:reaaia/views/auth/login/forget_password.dart';

import 'package:reaaia/views/auth/signup/signup.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/home/home_page.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  Map<String, dynamic> _loginInfo = {};

  bool loading = false;

  void checkPlatForm() {
    if (Platform.isAndroid) {
      _loginInfo['client_id'] = 2;
      _loginInfo['client_secret'] = '6sjRgmybLz8iR9pUQi1BHmHGCPAuAN7PiJRMWK6h';
    } else if (Platform.isIOS) {
      _loginInfo['client_id'] = 3;
      _loginInfo['client_secret'] = 'X0hau6BzbHnxL2XsvDigbQ6FeItpqcldsbiivrr0';
    } else if (kIsWeb) {
      _loginInfo['client_id'] = 4;
      _loginInfo['client_secret'] = 'VFzrXDR9DBNzZl6YYIsgum4HdOTEML6tAFAAx7WB';
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Builder(
        builder:(context)=> Form(
          key: _loginFormKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(82.5),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/reaaia_doctor.png",
                      scale: 2.3,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(8),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(14),
                        ),
                        Text(
                          'Reaaia',
                          style: TextStyle(
                              color: ColorsUtils.textGrey,
                              fontWeight: FontWeight.w800,
                              fontSize: ScreenUtil().setSp(25)),
                        ),
                        Text(
                          'For Doctor',
                          style: TextStyle(
                              color: ColorsUtils.textGrey,
                              fontSize: ScreenUtil().setSp(11)),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(37),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Log in',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: ScreenUtil().setSp(24)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(37),
                        ),
                        CustomTextField(
                          lablel: 'Phone Number*',
                          hasBorder: true,
                          onSaved: (value) {
                            _loginInfo['username'] = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field Required';
                            }else if(value.length<11){
                              return 'this Field Should no less than 11 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        CustomTextField(
                          lablel: 'Password*',
                          hasBorder: true,
                          hasPassword: true,
                          onSaved: (value) {
                            _loginInfo['password'] = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field Required';
                            }else if(value.length<8){
                              return 'this Field Should no less than 8 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(14),
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            InkWell(
                              onTap: () {
                                CustomFunctions.pushScreen(
                                    context: context, widget: ForgetPassword());
                              },
                              child: Text(
                                'Forget Password?',
                                style: TextStyle(
                                    color: ColorsUtils.onBoardingTextGrey,
                                    fontWeight: FontWeight.w800,
                                    fontSize: ScreenUtil().setSp(13)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(23),
                        ),
                        loading
                            ? CircularProgressIndicator()
                            : Container(
                                height: ScreenUtil().setHeight(50),
                                width: 236,
                                child: CustomRoundedButton(
                                  backgroundColor: ColorsUtils.primaryGreen,
                                  borderColor: ColorsUtils.primaryGreen,
                                  text: 'Log in',
                                  textColor: Colors.white,
                                  pressed: () async {
                                    if (_loginFormKey.currentState.validate()) {
                                      _loginFormKey.currentState.save();
                                      FocusManager.instance.primaryFocus.unfocus();

                                      checkPlatForm();
                                      _loginInfo['grant_type'] = 'password';
                                      _loginInfo['scope'] = '';
                                      setState(() {
                                        loading = true;
                                      });
                                      print(_loginInfo.toString());

                                      try {
                                        await loginProvider.login(_loginInfo);

                                        if (loginProvider.loginResponse.message ==
                                            'api.success.success') {
                                          setState(() {
                                            loading = false;
                                          });
                                          TokenUtil.saveToken(loginProvider.loginResponse.response.data.accessToken);
                                         CustomFunctions.pushScreenRepcalement(context: context,widget:  HomePage());
                                          print('Login Success');
                                        } else {
                                          setState(() {
                                            loading = false;
                                          });

                                          Functions.showCustomSnackBar(
                                            context: context,
                                            text: 'Mobile OR Password Wrong!',
                                            hasIcon: true,
                                            iconType: Icons.error_outline,
                                            iconColor: Colors.red,
                                          );
                                          print('Error Login');
                                        }
                                      } catch (error) {
                                        setState(() {
                                          loading = false;
                                        });
                                        Functions.showCustomSnackBar(
                                          context: context,
                                          text: 'Mobile OR Password Wrong!',
                                          hasIcon: true,
                                          iconType: Icons.error_outline,
                                          iconColor: Colors.red,
                                        );

                                      }
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                    }

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (ctx) =>
                                    //             CompleteRegister1()));
                                  },
                                ),
                              ),
                        SizedBox(
                          height: 59,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have account? ',
                              style: TextStyle(
                                  color: ColorsUtils.onBoardingTextGrey,
                                  fontSize: ScreenUtil().setSp(13)),
                            ),
                            InkWell(
                              onTap: () {
                                CustomFunctions.pushScreen(
                                    context: context, widget: SignUp());
                                // CustomFunctions.pushScreen(
                                //     context: context,
                                //     widget: CompleteRegister2());
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: ColorsUtils.blueColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: ScreenUtil().setSp(15)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
