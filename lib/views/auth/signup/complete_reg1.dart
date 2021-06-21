import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

import '../../customFunctions.dart';
import 'complete_req1_map.dart';

class CompleteRegister1 extends StatefulWidget {
  @override
  _CompleteRegister1State createState() => _CompleteRegister1State();
}

class _CompleteRegister1State extends State<CompleteRegister1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isMale=false;
  bool isFemale=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: ScreenUtil().setHeight(48)),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        CustomFunctions.popScreen(context);
                      },
                      child: Container(
                          //margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
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
                SizedBox(height: ScreenUtil().setHeight(20)),
                Row(
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(24)),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(17)),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Update your profile to get better engagment.',
                        style: TextStyle(
                            color: ColorsUtils.onBoardingTextGrey,
                            fontSize: ScreenUtil().setSp(13)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(14)),
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                            width: ScreenUtil().setWidth(89),
                            height: ScreenUtil().setHeight(89),
                            //padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(17)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: Image.asset(
                                'assets/complete_info1.png',
                                fit: BoxFit.cover,
                              ),
                            )),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey[300]),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.clear,
                                color: Colors.red,
                                size: 16,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(width: ScreenUtil().setWidth(14)),
                    Flexible(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomRoundedButton(
                              width: 185,
                              backgroundColor: ColorsUtils.primaryGreen,
                              borderColor: ColorsUtils.primaryGreen,
                              text: 'Update Avatar',
                              pressed: () {},
                              textColor: Colors.white,
                            ),
                            SizedBox(height: ScreenUtil().setHeight(12)),
                            Text(
                              'your avatar should be a friendly and inviting heat shot. clearly indentifiable as you.',
                              style: TextStyle(
                                  color: ColorsUtils.onBoardingTextGrey,
                                  fontSize: ScreenUtil().setSp(10)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(25)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: ' Full Name*',
                  hasBorder: true,
                  onSaved: (val) {},
                  errorMessage: 'Enter Full Name!',
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: ' Email*',
                  isEmail: true,
                  hasBorder: true,
                  onSaved: (val) {},
                  errorMessage: 'Enter Email!',
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: ' National ID*',
                  hasBorder: true,
                  onSaved: (val) {},
                  errorMessage: 'Enter Password!',
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: ' Password*',
                  hasBorder: true,
                  hasPassword: true,
                  onSaved: (val) {},
                  errorMessage: 'Enter Password!',
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Row(
                  children: [
                    ChooseGender(
                      iconName: 'assets/icons/ic_male.svg',
                      backgroundColor: isMale ?ColorsUtils.blueColor: Colors.white,
                      iconColor: isMale ?Colors.white: ColorsUtils.onBoardingTextGrey,
                      textColor: isMale ?Colors.black:ColorsUtils.onBoardingTextGrey,
                      genderName: 'MALE',
                      onTap: (){
                        setState(() {
                          isMale=true;
                          isFemale=false;
                        });
                      },
                    ),
                    SizedBox(width: ScreenUtil().setWidth(15)),
                    ChooseGender(
                      iconName: 'assets/icons/ic_female.svg',
                      backgroundColor: isFemale ?ColorsUtils.blueColor: Colors.white,
                      iconColor: isFemale ?Colors.white: ColorsUtils.onBoardingTextGrey,
                      textColor: isFemale ?Colors.black:ColorsUtils.onBoardingTextGrey,
                      genderName: 'FEMALE',
                      onTap: (){
                        setState(() {
                          isMale=false;
                          isFemale=true;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: ' Date of Birthday*',
                  hasBorder: true,
                  icon: Icon(Icons.date_range,color: ColorsUtils.blueColor,),
                  onSaved: (val) {},
                  errorMessage: 'Enter Date!',
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: ' Main Address*',
                  hasBorder: true,
                  errorMessage: 'Enter Address!',
                  icon: Icon(Icons.location_on_outlined,color: ColorsUtils.blueColor,),
                  sufficIcon: Icon(Icons.my_location,color: ColorsUtils.onBoardingTextGrey,),
                ),
                SizedBox(height: ScreenUtil().setHeight(20),),
                Container(
                  height: ScreenUtil().setHeight(50),
                  width: 236,
                  child: CustomRoundedButton(
                    backgroundColor: ColorsUtils.primaryGreen,
                    borderColor: ColorsUtils.primaryGreen,
                    icon: Icon(Icons.arrow_forward,color: Colors.white,),
                    text: 'Continue',
                    pressed: () {
                      CustomFunctions.pushScreen(
                          context: context, widget: CompleteRequest1Map());
                    },
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChooseGender extends StatelessWidget {
  final String iconName;
  final String genderName;
  final Color iconColor;
  final Color textColor;
  final Color backgroundColor;
  final Function onTap;

  ChooseGender(
      {this.iconName, this.genderName, this.iconColor, this.textColor,this.onTap,this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            Container(
              width: ScreenUtil().setWidth(54),
              height: ScreenUtil().setHeight(53),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(15)),
              child: SvgPicture.asset(
                iconName,
                color: iconColor,
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
            Text(
              genderName,
              style: TextStyle(
                  color: textColor,
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
