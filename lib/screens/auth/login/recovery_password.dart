import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/model/data/loginResponse/foreget_pass_response.dart';
import 'package:reaaia/screens/auth/login/change_password.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/login_provider.dart';



class RecoveryPassword extends StatefulWidget {

  final ForgetPassResponse forgetPassResponse;
  RecoveryPassword({@required this.forgetPassResponse});
  @override
  _RecoveryPasswordState createState() => _RecoveryPasswordState();
}

class _RecoveryPasswordState extends State<RecoveryPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  Map<String, dynamic> _forgetPassInfo = {};
  bool loading = false;

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
      body: Builder(
        builder:(context)=> Form(
          key: _formKey,
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
                    margin:
                        EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(7)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: ScreenUtil().setHeight(40)),
                          Row(
                            children: [
                              Text(
                                'Recovery Password',
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
                                  'Reset code was sent to your email. Please enter the code and create new password.',
                                  style: TextStyle(
                                      color: ColorsUtils.onBoardingTextGrey,
                                      fontSize: ScreenUtil().setSp(13)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(33),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Reset Code',
                                      style: TextStyle(
                                          color: ColorsUtils.onBoardingTextGrey,
                                          fontSize: ScreenUtil().setSp(13)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      PinCodeTextField(
                                        controller: _controller,
                                        autofocus: true,
                                        defaultBorderColor: ColorsUtils.borderColor,
                                        hasTextBorderColor: ColorsUtils.greenBorder,
                                        maxLength: 5,
                                        onTextChanged: (text) {
                                          _forgetPassInfo['otp'] = text;
                                        },
                                        onDone: (text) {},
                                        pinBoxWidth: 50,
                                        pinBoxHeight: 55,
                                        pinBoxRadius: 14,
                                        wrapAlignment: WrapAlignment.spaceAround,
                                        pinBoxDecoration: ProvidedPinBoxDecoration
                                            .defaultPinBoxDecoration,
                                        pinTextStyle: TextStyle(fontSize: 22.0),
                                        pinTextAnimatedSwitcherTransition:
                                            ProvidedPinBoxTextAnimation
                                                .scalingTransition,
//                    pinBoxColor: Colors.green[100],
                                        pinTextAnimatedSwitcherDuration:
                                            Duration(milliseconds: 300),
//                    highlightAnimation: true,
                                        highlightAnimationBeginColor: Colors.black,
                                        highlightAnimationEndColor: Colors.white12,

                                        keyboardType: TextInputType.number,
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.check_circle_outline,
                                            color: ColorsUtils.greenBorder,
                                          ),
                                          onPressed: null)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(36),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t receive code? ',
                                style: TextStyle(
                                    color: ColorsUtils.onBoardingTextGrey,
                                    fontSize: ScreenUtil().setSp(13)),
                              ),
                              Text(
                                'Resend it',
                                style: TextStyle(
                                    color: ColorsUtils.blueColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: ScreenUtil().setSp(15)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(29),
                          ),

                         loading?CircularProgressIndicator(): Container(
                            height: ScreenUtil().setHeight(50),
                            width: 236,
                            child: CustomRoundedButton(
                              backgroundColor: ColorsUtils.primaryGreen,
                              borderColor: ColorsUtils.primaryGreen,
                              text: 'Verify',
                              pressed: () async{
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  if(_controller.text.length==5){
                                    setState(() {
                                      loading=true;
                                    });
                                    checkPlatForm();
                                    _forgetPassInfo['grant_type'] = 'activation';
                                    _forgetPassInfo['token'] = widget.forgetPassResponse.response.data.token;
                                    print(_forgetPassInfo.toString());
                                    try {
                                      await loginProvider
                                          .forgetPasswordVerifyOtp(_forgetPassInfo);
                                      if (loginProvider.loginResponse.status ==
                                          200) {
                                        setState(() {
                                          loading=false;
                                        });
                                        CustomFunctions.pushScreen(
                                            context: context,
                                            widget: ChangePassword());
                                      } else {
                                        setState(() {
                                          loading=false;
                                        });
                                        Functions.showCustomSnackBar(
                                          context: context,
                                          text: 'Wrong Code!',
                                          hasIcon: true,
                                          iconType: Icons.error_outline,
                                          iconColor: Colors.red,
                                        );
                                      }
                                    } catch (error) {
                                      setState(() {
                                        loading=false;
                                      });
                                      Functions.showCustomSnackBar(
                                        context: context,
                                        text: 'Server Error! $error',
                                        hasIcon: true,
                                        iconType: Icons.error_outline,
                                        iconColor: Colors.red,
                                      );
                                    }
                                  }else{

                                    Functions.showCustomSnackBar(
                                      context: context,
                                      text: 'Code Should be 5 digits',
                                      hasIcon: true,
                                      iconType: Icons.error_outline,
                                      iconColor: Colors.red,
                                    );
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
      ),
    );
  }
}
