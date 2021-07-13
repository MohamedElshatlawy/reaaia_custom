import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/sign_up_provider.dart';
import 'package:path/path.dart' as path;

class AddAwardPage extends StatefulWidget {
  @override
  _AddAwardPageState createState() => _AddAwardPageState();
}

class _AddAwardPageState extends State<AddAwardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File awardImage;

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Padding(
            padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 25.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24.0),
                  topLeft: Radius.circular(24.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Award',
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(17)),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(16)),
                  CustomTextField(
                    filledColor: Colors.white,
                    lablel: ' Award Name ',
                    hasBorder: true,
                    onSaved: (val) {

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field Required';
                      }
                      return null;
                    },
                    onChanged: (val){

                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  CustomTextField(
                    filledColor: Colors.white,
                    lablel: ' Year',
                    hasBorder: true,
                    onSaved: (val) {

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field Required';
                      }
                      return null;
                    },
                    onChanged: (val) {

                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20),),
                  InkWell(
                    onTap: () async {
                      final pickedImage =
                      await Functions.pickImage();
                      if (pickedImage != null) {
                        setState(() {
                          awardImage = pickedImage;
                        });
                        try {
                          await signUpProvider.uploadPicture(
                              collection:
                              'Doctor award images',
                              file: awardImage);
                          if (signUpProvider.tokenPicture !=
                              null) {
                            // _certifications[index].image = [signUpProvider.tokenPicture
                            // ];
                            // print(jsonEncode(_certifications)
                            //     .toString());
                            Functions.showCustomSnackBar(
                              context: context,
                              text:
                              'Picture Upload Successfully',
                              hasIcon: true,
                              iconType: Icons.done,
                              iconColor: Colors.green,
                            );
                          } else {
                            Functions.showCustomSnackBar(
                              context: context,
                              text: 'Picture Upload Failed!',
                              hasIcon: true,
                              iconType: Icons.error_outline,
                              iconColor: Colors.red,
                            );
                          }
                        } catch (err) {
                          Functions.showCustomSnackBar(
                            context: context,
                            text: 'Picture Upload Failed!',
                            hasIcon: true,
                            iconType: Icons.error_outline,
                            iconColor: Colors.red,
                          );
                        }
                      } else {
                        Functions.showCustomSnackBar(
                          context: context,
                          text: 'Picture Upload Failed!',
                          hasIcon: true,
                          iconType: Icons.error_outline,
                          iconColor: Colors.red,
                        );
                      }
                    },
                    child: Container(
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().setHeight(50),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey[300]),
                          borderRadius:
                          BorderRadius.circular(8)),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(24),
                            height:
                            ScreenUtil().setHeight(24),
                            //margin: EdgeInsets.symmetric(horizontal: 10.0),
                            child: SvgPicture.asset(
                              'assets/icons/fi-rr-cloud-upload.svg',
                              color: ColorsUtils.blueColor,
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(10),
                          ),
                          Flexible(
                            child: Text(
                              awardImage != null
                                  ? path.basename(
                                  awardImage
                                      .path)
                                  : 'Attach Award Photo',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                  ScreenUtil().setSp(13),
                                  color:
                                  ColorsUtils.textGrey),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: ScreenUtil().setHeight(50),
                      width: 236,
                      child: CustomRoundedButton(
                        backgroundColor: ColorsUtils.primaryGreen,
                        borderColor: ColorsUtils.primaryGreen,
                        text: 'Add',
                        pressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            Navigator.pop(context);
                          }

                        },
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),


    );
  }
}
