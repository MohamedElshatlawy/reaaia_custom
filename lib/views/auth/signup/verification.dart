import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/views/auth/login/data_validation_msg.dart';
import 'package:reaaia/views/auth/login/password_success_changed.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

class Verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Container(
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

                                    defaultBorderColor: ColorsUtils.borderColor,
                                    hasTextBorderColor: ColorsUtils.greenBorder,
                                    maxLength: 5,
                                    onTextChanged: (text) {},
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
                        height: ScreenUtil().setHeight(34),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(50),
                        width: 236,
                        child: CustomRoundedButton(
                          backgroundColor: ColorsUtils.primaryGreen,
                          borderColor: ColorsUtils.primaryGreen,
                          text: 'Verify',
                          pressed: () {
                            CustomFunctions.pushScreen(
                                context: context,
                                widget: PasswordSuccessChanged());
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
                            'Don\'t get a code?(Wait 20 S) ',
                            style: TextStyle(
                                color: ColorsUtils.onBoardingTextGrey,
                                fontSize: ScreenUtil().setSp(13)),
                          ),
                          Text(
                            'Resend Code',
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
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
