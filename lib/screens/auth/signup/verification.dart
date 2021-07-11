import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/screens/auth/signup/complete_reg1.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/sign_up_provider.dart';


class Verification extends StatefulWidget {
  final String mobileNumber;

  const Verification({@required this.mobileNumber});

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool loading = false;
  TextEditingController _controller = TextEditingController();
  int _counter = 20;
  Timer _timer;
  String verificationCode;
  Map<String, dynamic> _verifyForm;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    _counter = 30;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Builder(
        builder: (context) => Container(
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
                              'Verification',
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
                                'Please check you message for a six-digit security code and enter it below.',
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
                                    'Verification Code',
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
                                      autofocus: true,

                                      defaultBorderColor:
                                          ColorsUtils.borderColor,
                                      hasTextBorderColor:
                                          ColorsUtils.greenBorder,
                                      maxLength: 5,
                                      controller: _controller,
                                      onTextChanged: (text) {
                                        verificationCode = text;
                                      },
                                      onDone: (text) {
                                        verificationCode = text;
                                      },
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
                                      highlightAnimationBeginColor:
                                          Colors.black,
                                      highlightAnimationEndColor:
                                          Colors.white12,

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
                          height: ScreenUtil().setHeight(34),
                        ),
                        loading
                            ? CircularProgressIndicator()
                            : Container(
                                height: ScreenUtil().setHeight(50),
                                width: 236,
                                child: CustomRoundedButton(
                                  backgroundColor: ColorsUtils.primaryGreen,
                                  borderColor: ColorsUtils.primaryGreen,
                                  text: 'Verify',
                                  pressed: () async {
                                    //FocusManager.instance.primaryFocus.unfocus();
                                    if (_controller.text != null &&
                                        _controller.text.isNotEmpty && _controller.text.length==5) {
                                      _verifyForm = {
                                        "mobile_number": widget.mobileNumber,
                                        "code": _controller.text,
                                      };
                                      print(_verifyForm.toString());
                                      setState(() {
                                        loading = true;
                                      });

                                      try {
                                        await signUpProvider
                                            .verifyWithMobileNumber(
                                                _verifyForm);

                                        if (signUpProvider
                                                .verificationResponseModel
                                                .message ==
                                            'api.success.success') {
                                          print(signUpProvider
                                              .verificationResponseModel
                                              .response
                                              .data
                                              .id
                                              .toString());
                                          setState(() {
                                            loading = false;
                                          });
                                          CustomFunctions.pushScreen(
                                              context: context,
                                              widget: CompleteRegister1(
                                                userId: signUpProvider
                                                    .verificationResponseModel
                                                    .response
                                                    .data
                                                    .id,
                                              ));
                                          print('Succeed verify');
                                        } else {
                                          setState(() {
                                            loading = false;
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
                                          loading = false;
                                        });
                                        Functions.showCustomSnackBar(
                                          context: context,
                                          text: 'NetWork Error!',
                                          hasIcon: true,
                                          iconType: Icons.error_outline,
                                          iconColor: Colors.red,
                                        );
                                      }
                                    } else {
                                      Functions.showCustomSnackBar(
                                        context: context,
                                        text: 'Code Should equal 5 digits',
                                        hasIcon: true,
                                        iconType: Icons.error_outline,
                                        iconColor: Colors.red,
                                      );
                                    }
                                  },
                                  textColor: Colors.white,
                                ),
                              ),
                        SizedBox(
                          height: ScreenUtil().setHeight(24),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t get a code?(Wait 00:${_counter.toString().padLeft(2, "0")}) ',
                              style: TextStyle(
                                  color: ColorsUtils.onBoardingTextGrey,
                                  fontSize: ScreenUtil().setSp(13)),
                            ),
                            GestureDetector(
                              onTap: _counter > 0
                                  ? () {}
                                  : () async {
                                      _startTimer();

                                      try {
                                        await signUpProvider
                                            .resendCode(widget.mobileNumber);
                                        if (signUpProvider
                                                .messageResponseSignUp ==
                                            'Accepted') {
                                          Functions.showCustomSnackBar(
                                            context: context,
                                            text: 'Code Resend Successfully',
                                            hasIcon: true,
                                            iconType: Icons.done,
                                            iconColor: Colors.green,
                                          );
                                          print('Resend Succeed');
                                        } else {
                                          Functions.showCustomSnackBar(
                                            context: context,
                                            text: 'Code Resend Failed',
                                            hasIcon: true,
                                            iconType: Icons.error_outline,
                                            iconColor: Colors.red,
                                          );
                                          print('Resend Error');
                                        }
                                      } catch (err) {
                                        Functions.showCustomSnackBar(
                                          context: context,
                                          text: 'Code Resend Failed',
                                          hasIcon: true,
                                          iconType: Icons.error_outline,
                                          iconColor: Colors.red,
                                        );
                                        print('Resend Error');
                                      }
                                    },
                              child: Text(
                                'Resend Code',
                                style: TextStyle(
                                    color: _counter > 0
                                        ? Colors.grey
                                        : ColorsUtils.blueColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: ScreenUtil().setSp(15)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(29),
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
