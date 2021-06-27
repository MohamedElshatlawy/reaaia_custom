import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/phoneCode_provider.dart';
import 'package:reaaia/viewModels/sign_up_provider.dart';
import 'package:reaaia/views/auth/login/login.dart';
import 'package:reaaia/views/auth/signup/verification.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    String mobileNumber;
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    var phoneCodeProvider = Provider.of<PhoneCodeProvider>(context);
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Builder(
        builder:(context)=> Form(
          key: _signupFormKey,
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
                                    side: BorderSide(
                                        color: ColorsUtils.borderColor)),
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
                                  onSaved: (value) {
                                    mobileNumber =
                                        phoneCodeProvider.phoneCode + value;

                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field Required';
                                    }
                                    else if(value.length<10){
                                      return 'this Field Should no less than 10 digits';
                                    }
                                    return null;
                                  },
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
                          loading
                              ? CircularProgressIndicator()
                              : Container(
                                  height: ScreenUtil().setHeight(50),
                                  width: 236,
                                  child: CustomRoundedButton(
                                    backgroundColor: ColorsUtils.primaryGreen,
                                    borderColor: ColorsUtils.primaryGreen,
                                    text: 'Sign Up',
                                    pressed: () async {
                                      if (_signupFormKey.currentState
                                          .validate()) {
                                        _signupFormKey.currentState.save();
                                        FocusManager.instance.primaryFocus.unfocus();
                                        print(mobileNumber);
                                        if(mobileNumber.length==14 || mobileNumber.length==13){
                                          setState(() {
                                            loading = true;
                                          });

                                          mobileNumber= mobileNumber.trim();
                                          if (mobileNumber.length == 14) {
                                            mobileNumber = mobileNumber.replaceFirst('0', '');
                                          }


                                          try{

                                            await signUpProvider
                                                .signUpWithMobileNumber(mobileNumber);
                                            if (signUpProvider.messageResponseSignUp == 'Accepted') {
                                              setState(() {
                                                loading = false;
                                              });
                                              CustomFunctions.pushScreen(
                                                  context: context,
                                                  widget: Verification(
                                                    mobileNumber: mobileNumber,
                                                  ));
                                              print('Succeed Sign Up');
                                            } else if (signUpProvider.messageResponseSignUp == 'Found') {
                                              setState(() {
                                                loading = false;
                                              });
                                              Functions.showCustomSnackBar(
                                                context: context,
                                                text: 'Mobile Number Found!',
                                                hasIcon: true,
                                                iconType: Icons.error_outline,
                                                iconColor: Colors.red,
                                              );
                                            }else{
                                              setState(() {
                                                loading = false;
                                              });
                                              Functions.showCustomSnackBar(
                                                context: context,
                                                text: 'Error SignUP!',
                                                hasIcon: true,
                                                iconType: Icons.error_outline,
                                                iconColor: Colors.red,
                                              );
                                            }

                                          }catch(err){
                                            setState(() {
                                              loading = false;
                                            });
                                            Functions.showCustomSnackBar(
                                              context: context,
                                              text: 'Error SignUP!',
                                              hasIcon: true,
                                              iconType: Icons.error_outline,
                                              iconColor: Colors.red,
                                            );
                                          }

                                        }else{
                                          Functions.showCustomSnackBar(
                                            context: context,
                                            text: 'Enter A Valid Mobile Number!',
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
        ),
      ),
    );
  }
}
