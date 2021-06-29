

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/login_provider.dart';
import 'package:reaaia/views/auth/login/password_success_changed.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

import '../../customFunctions.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _forgetPassInfo = {};
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Builder(
        builder: (context) => Form(
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
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(7)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: ScreenUtil().setHeight(40)),
                          Row(
                            children: [
                              Text(
                                'Set New Password',
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
                          CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This Field Required';
                              }else if(value.length<8){
                                return 'this Field Should more than 8 digits';
                              }
                              return null;
                            },

                            lablel: 'New Password*',
                            hasBorder: true,
                            hasPassword: true,
                            onSaved: (val) {
                              _forgetPassInfo['password'] = val;
                            },
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This Field Required';
                              }else if(value.length<8){
                                return 'this Field Should more than 8 digits';
                              }
                              return null;
                            },
                              lablel: 'Confirm New Password*',
                              hasBorder: true,
                              hasPassword: true,
                              onSaved: (val) {
                                _forgetPassInfo['password_confirmation'] = val;
                              },
                             ),
                          SizedBox(
                            height: ScreenUtil().setHeight(30.5),
                          ),
                         loading?CircularProgressIndicator(): Container(
                            height: ScreenUtil().setHeight(50),
                            width: 236,
                            child: CustomRoundedButton(
                              backgroundColor: ColorsUtils.primaryGreen,
                              borderColor: ColorsUtils.primaryGreen,
                              text: 'Change Password',
                              pressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  FocusManager.instance.primaryFocus.unfocus();

                                  if (_forgetPassInfo['password'] ==
                                      _forgetPassInfo[
                                          'password_confirmation']) {
                                    setState(() {
                                      loading=true;
                                    });
                                    try {
                                      await loginProvider
                                          .resetPassword(
                                              _forgetPassInfo);
                                      if (loginProvider.status ==
                                          200) {
                                        setState(() {
                                          loading=false;
                                        });
                                        CustomFunctions.pushScreen(
                                            context: context,
                                            widget: PasswordSuccessChanged());
                                      } else {
                                        setState(() {
                                          loading=false;
                                        });
                                        Functions.showCustomSnackBar(
                                          context: context,
                                          text: 'Can\'t Change Passwrod',
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
                                  } else {
                                    Functions.showCustomSnackBar(
                                      context: context,
                                      text: 'Password didn\'t match',
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
