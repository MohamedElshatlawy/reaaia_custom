import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/login_provider.dart';
import 'package:reaaia/views/auth/login/data_validation_msg.dart';
import 'package:reaaia/views/auth/login/recovery_password.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _forgetPassFormKey = GlobalKey<FormState>();

  Map<String, dynamic> _forgetPassInfo = {};

  void checkPlatForm() {
    if (Platform.isAndroid) {
      _forgetPassInfo['client_id'] = 2;
      _forgetPassInfo['client_secret'] =
          '6sjRgmybLz8iR9pUQi1BHmHGCPAuAN7PiJRMWK6h';
    } else if (Platform.isIOS) {
      _forgetPassInfo['client_id'] = 3;
      _forgetPassInfo['client_secret'] =
          'X0hau6BzbHnxL2XsvDigbQ6FeItpqcldsbiivrr0';
    } else if (kIsWeb) {
      _forgetPassInfo['client_id'] = 4;
      _forgetPassInfo['client_secret'] =
          'VFzrXDR9DBNzZl6YYIsgum4HdOTEML6tAFAAx7WB';
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Form(
        key: _forgetPassFormKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
          child: Container(
            child: Column(
              children: [
                SizedBox(height: ScreenUtil().setHeight(50)),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        CustomFunctions.popScreen(context);
                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(7)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: ScreenUtil().setHeight(40)),
                        Row(
                          children: [
                            Text(
                              'Forget Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: ScreenUtil().setSp(24)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(17),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Please enter your email below to receive your password reset instructions.',
                                style: TextStyle(
                                    color: ColorsUtils.onBoardingTextGrey,
                                    fontSize: ScreenUtil().setSp(13)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(31),
                        ),
                        CustomTextField(
                          lablel: 'Email / Phone Number*',
                          hasBorder: true,
                          errorMessage: 'enter a valid Mobile Number',
                          onSaved: (value) {
                            _forgetPassInfo['username'] = value;
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(30.5),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(50),
                          width: 236,
                          child: CustomRoundedButton(
                            backgroundColor: ColorsUtils.primaryGreen,
                            borderColor: ColorsUtils.primaryGreen,
                            text: 'Send Email',
                            pressed: () async {
                              if (_forgetPassFormKey.currentState.validate()) {
                                _forgetPassFormKey.currentState.save();
                                checkPlatForm();
                                _forgetPassInfo['grant_type'] = 'activation';
                                print(_forgetPassInfo.toString());
                                try {
                                  await loginProvider
                                      .forgetPasswordSendOtp(_forgetPassInfo);
                                  if (loginProvider.forgetPassResponse.status ==
                                      200) {
                                    print('Success');
                                    CustomFunctions.pushScreen(
                                        context: context,
                                        widget: RecoveryPassword(
                                          forgetPassResponse:
                                              loginProvider.forgetPassResponse,
                                        ));
                                  } else {
                                    print('Falid');
                                  }
                                } catch (error) {
                                  print('Failed Eroorrrr');
                                }
                              }
                            },
                            textColor: Colors.white,
                          ),
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
