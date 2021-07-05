import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/data/clinicsModel/service_model.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';
import 'package:path/path.dart' as path;

class AddServiceClinic extends StatefulWidget {
  @override
  _AddServiceClinicState createState() => _AddServiceClinicState();
}

class _AddServiceClinicState extends State<AddServiceClinic> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<File> images=[];

  ServiceModel _serviceModel=ServiceModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Builder(
        builder:(context)=>Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtil().setHeight(48)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              color: ColorsUtils.blueColor,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(17)),
                  Row(
                    children: [
                      Text(
                        'Add Service',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil().setSp(24)),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(30)),
                  CustomTextField(
                    filledColor: Colors.white,
                    lablel: ' Service Name',
                    hasBorder: true,
                    onSaved: (val) {
                      _serviceModel.serviceName=val;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  CustomTextField(
                    filledColor: Colors.white,
                    lablel: ' Service Description',
                    hasBorder: true,
                    onSaved: (val) {
                      _serviceModel.serviceDesc=val;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  CustomTextField(
                    filledColor: Colors.white,
                    lablel: ' Service requirements',
                    hasBorder: true,
                    onSaved: (val) {
                      _serviceModel.serviceRequirements=val;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  CustomTextField(
                    filledColor: Colors.white,
                    lablel: ' Service Cost',
                    hasBorder: true,
                    onSaved: (val) {
                      _serviceModel.serviceCost=val;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  CustomTextField(
                    filledColor: Colors.white,
                    lablel: ' DisCount %',
                    hasBorder: true,
                    onSaved: (val) {
                      _serviceModel.serviceDiscount=val;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  InkWell(
                    onTap: () async {
                      final pickedImages =
                      await Functions.pickMultipleImage();
                      if (pickedImages != null) {
                        setState(() {
                          images = pickedImages;
                          _serviceModel.images=images;
                        });

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
                              images.isNotEmpty
                                  ? path.basename(
                                  images.first.path)
                                  : 'Upload image(s)',
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
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: ScreenUtil().setHeight(50),
                      width: 236,
                      child: CustomRoundedButton(
                        backgroundColor: ColorsUtils.primaryGreen,
                        borderColor: ColorsUtils.primaryGreen,
                        text: 'Save',
                        pressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            if(images.isNotEmpty){
                              Provider.of<ClinicsProvider>(context,listen: false).addServiceClinic(_serviceModel);
                              Navigator.pop(context);
                            }else{

                              Functions.showCustomSnackBar(
                                context: context,
                                text: 'The Field Images Required!',
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
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
