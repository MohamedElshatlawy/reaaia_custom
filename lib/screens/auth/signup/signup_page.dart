import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/screens/auth/login/login_page.dart';
import 'package:reaaia/screens/auth/signup/verification.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';
import 'package:reaaia/viewModels/phoneCode_provider.dart';
import 'package:reaaia/viewModels/sign_up_provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                               AppLocalizations.of(context).translate('welcomeReaaia'),
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
                                AppLocalizations.of(context).translate('signUp'),
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
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
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
                                    lablel: AppLocalizations.of(context).translate('phoneNumber'),
                                    hasBorder: true,
                                    isMobile: true,
                                    onSaved: (value) {
                                      mobileNumber =
                                          phoneCodeProvider.phoneCode + value;

                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context).translate('fieldRequiredValidate');
                                      }
                                      else if(value.length<10){
                                        return AppLocalizations.of(context).translate('phoneNumberValidate2');
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(15),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text:
                            AppLocalizations.of(context).translate('terms1'),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: ColorsUtils.onBoardingTextGrey)),
                                TextSpan(
                                    text:  AppLocalizations.of(context).translate('terms2'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsUtils.blueColor)),
                                TextSpan(
                                    text:  AppLocalizations.of(context).translate('terms3'),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: ColorsUtils.onBoardingTextGrey)),
                                TextSpan(
                                    text:  AppLocalizations.of(context).translate('terms4'),
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
                                    text: AppLocalizations.of(context).translate('signUp'),
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
                                            if (signUpProvider.messageResponseSignUp == 'Created') {
                                              setState(() {
                                                loading = false;
                                              });
                                              CustomFunctions.pushScreen(
                                                  context: context,
                                                  widget: Verification(
                                                    mobileNumber: mobileNumber,
                                                  ));
                                              print('Succeed Sign Up');
                                            } else if (signUpProvider.messageResponseSignUp == 'Accepted') {
                                              setState(() {
                                                loading = false;
                                              });
                                              Functions.showCustomSnackBar(
                                                context: context,
                                                text: AppLocalizations.of(context).translate('mobileFound'),
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
                                                text: AppLocalizations.of(context).translate('errorSignUp'),
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
                                              text: AppLocalizations.of(context).translate('errorSignUp'),
                                              hasIcon: true,
                                              iconType: Icons.error_outline,
                                              iconColor: Colors.red,
                                            );
                                          }

                                        }else{
                                          Functions.showCustomSnackBar(
                                            context: context,
                                            text: AppLocalizations.of(context).translate('enterValidNumber'),
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
                                AppLocalizations.of(context).translate('haveAccount'),
                                style: TextStyle(
                                    color: ColorsUtils.onBoardingTextGrey,
                                    fontSize: ScreenUtil().setSp(13)),
                              ),
                              InkWell(
                                onTap: () {
                                  CustomFunctions.pushScreen(
                                      context: context, widget: LoginPage());
                                },
                                child: Text(
                                  AppLocalizations.of(context).translate('login'),
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
