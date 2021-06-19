import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/views/auth/login/forget_password.dart';
import 'package:reaaia/views/auth/signup/complete_reg1.dart';
import 'package:reaaia/views/auth/signup/congrats.dart';
import 'package:reaaia/views/auth/signup/request_sent_success.dart';
import 'package:reaaia/views/auth/signup/signup.dart';
import 'package:reaaia/views/auth/signup/sorry.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Container(
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
                      lablel: 'Email / Phone Number*',
                      hasBorder: true,
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    CustomTextField(
                      lablel: 'Password*',
                      hasBorder: true,
                      hasPassword: true,
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
                    Container(
                      height: ScreenUtil().setHeight(50),
                      width: 236,
                      child: CustomRoundedButton(
                        backgroundColor: ColorsUtils.primaryGreen,
                        borderColor: ColorsUtils.primaryGreen,
                        text: 'Log in',
                        textColor: Colors.white,
                        pressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => CompleteRegister1()));
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
    );
  }
}
