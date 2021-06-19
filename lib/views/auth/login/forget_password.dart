import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/views/auth/login/data_validation_msg.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

class ForgetPassword extends StatelessWidget {
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
                          pressed: () {
                            CustomFunctions.pushScreen(
                                context: context,
                                widget: DataValidationMessage());
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
    );
  }
}
