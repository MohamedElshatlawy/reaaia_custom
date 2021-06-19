import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/FontsUtils.dart';
import 'package:reaaia/views/auth/login/data_validation_msg.dart';
import 'package:reaaia/views/auth/login/login.dart';
import 'package:reaaia/views/auth/signup/verification.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

class SignUp extends StatelessWidget {
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
                            'Welcome to Reaaia',
                            style: TextStyle(
                                color: ColorsUtils.onBoardingTextGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(15)),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(18)),
                      Row(
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: ScreenUtil().setSp(24)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(38),
                      ),
                      Row(
                        children: [
                          Card(
                            margin: EdgeInsets.all(0),
                            color: ColorsUtils.greyColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side:
                                    BorderSide(color: ColorsUtils.borderColor)),
                            child: CountryCodePicker(
                              onChanged: print,

                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: 'EG',
                              favorite: ['EG', 'SA'],

                              // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
                            ),
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Expanded(
                            child: CustomTextField(
                              lablel: 'Phone Number*',
                              hasBorder: true,
                              isMobile: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    'By clicking sign up you are agreeing to the ',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorsUtils.onBoardingTextGrey)),
                            TextSpan(
                                text: 'Terms of use',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsUtils.blueColor)),
                            TextSpan(
                                text: ' and the ',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorsUtils.onBoardingTextGrey)),
                            TextSpan(
                                text: 'Privacy policy',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsUtils.blueColor)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(53),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(50),
                        width: 236,
                        child: CustomRoundedButton(
                          backgroundColor: ColorsUtils.primaryGreen,
                          borderColor: ColorsUtils.primaryGreen,
                          text: 'Sign Up',
                          pressed: () {
                            CustomFunctions.pushScreen(
                                context: context, widget: Verification());
                          },
                          textColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                                color: ColorsUtils.onBoardingTextGrey,
                                fontSize: ScreenUtil().setSp(13)),
                          ),
                          InkWell(
                            onTap: () {
                              CustomFunctions.pushScreen(
                                  context: context, widget: Login());
                            },
                            child: Text(
                              'Log in',
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
    );
  }
}
