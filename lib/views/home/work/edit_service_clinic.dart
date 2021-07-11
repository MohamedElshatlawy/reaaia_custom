import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/data/clinicsModel/add_service_model.dart';
import 'package:reaaia/data/clinicsModel/service_model.dart';
import 'package:reaaia/data/clinicsModel/service_model_new.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';
import 'package:path/path.dart' as path;

class EditServiceClinic extends StatefulWidget {

  final ServiceData serviceModel;
  final int index;
  final int clinicID;
  EditServiceClinic({@required this.serviceModel,@required this.index,@required this.clinicID});

  @override
  _EditServiceClinicState createState() => _EditServiceClinicState();
}

class _EditServiceClinicState extends State<EditServiceClinic> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading=false;

  List<String> images=[];
  List<File> imagesFiles=[];
  List<MultipartFile> multipartImages=[];

  //ServiceData _serviceModel=ServiceData();

  Name serviceName=Name();
  Name serviceDesc=Name();
  Name serviceReq =Name();
  AddServiceModel _addServiceModel=AddServiceModel();

  Future<void> convertImagesToFiles(List<File> files) async{
    multipartImages.clear();
    files.map((e)async{
      multipartImages.add(

          await MultipartFile.fromPath(
              "files", e.path)
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    images=widget.serviceModel.images;
    _addServiceModel.files=widget.serviceModel.images;
    //_serviceModel.images=widget.serviceModel.images;
  }

  @override
  Widget build(BuildContext context) {
    final clinicProvider = Provider.of<ClinicsProvider>(context, listen: false);
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
                        'Edit Service',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil().setSp(24)),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(30)),
                  CustomTextField(
                    initialValue: widget.serviceModel.name,
                    filledColor: Colors.white,
                    lablel: ' Service Name',
                    hasBorder: true,
                    onSaved: (val) {
                      serviceName.en=val;
                      serviceName.ar=val;
                      _addServiceModel.name=serviceName;
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
                    initialValue: widget.serviceModel.description,
                    filledColor: Colors.white,
                    lablel: ' Service Description',
                    hasBorder: true,
                    onSaved: (val) {
                      serviceDesc.en=val;
                      serviceDesc.ar=val;
                      _addServiceModel.description=serviceDesc;
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
                    initialValue: widget.serviceModel.requirements,
                    filledColor: Colors.white,
                    lablel: ' Service requirements',
                    hasBorder: true,
                    onSaved: (val) {
                      serviceReq.en=val;
                      serviceReq.ar=val;
                      _addServiceModel.requirements=serviceReq;
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
                    initialValue: widget.serviceModel.price,
                    filledColor: Colors.white,
                    lablel: ' Service Cost',
                    hasBorder: true,
                    onSaved: (val) {
                      _addServiceModel.price=double.tryParse(val).toInt();
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
                    initialValue: widget.serviceModel.discountPercentage.toString(),
                    filledColor: Colors.white,
                    lablel: ' DisCount %',
                    hasBorder: true,
                    onSaved: (val) {
                      _addServiceModel.discountPercentage=int.tryParse(val);
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
                          imagesFiles = pickedImages;
                        });
                        try{
                          await  clinicProvider.uploadServiceImages(collection: 'Services Images',files: imagesFiles);
                          if( clinicProvider.tokenImages!=null){

                            _addServiceModel.files=[clinicProvider.tokenImages];
                            print('we found token ${clinicProvider.tokenImages.toString()}');
                            Functions.showCustomSnackBar(
                              context: context,
                              text: 'Picture Upload Successfully',
                              hasIcon: true,
                              iconType: Icons.done,
                              iconColor: Colors.green,
                            );
                          }else{
                            Functions.showCustomSnackBar(
                              context: context,
                              text: 'Picture Upload Failed!',
                              hasIcon: true,
                              iconType: Icons.error_outline,
                              iconColor: Colors.red,
                            );
                          }
                        }catch(err){
                          Functions.showCustomSnackBar(
                            context: context,
                            text: 'Images Upload Failed!',
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
                              images.isNotEmpty
                                  ? path.basename(
                                  images.first)
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
                  loading?Center(child: CircularProgressIndicator()):    Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: ScreenUtil().setHeight(50),
                      width: 236,
                      child: CustomRoundedButton(
                        backgroundColor: ColorsUtils.primaryGreen,
                        borderColor: ColorsUtils.primaryGreen,
                        text: 'Save',
                        pressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            if(images!=null){
                              _addServiceModel.clinicId=widget.clinicID;

                              setState(() {
                                loading = true;
                              });
                              try {
                                final responseStatus=  await clinicProvider.editService(widget.serviceModel.id,_addServiceModel,multipartImages);
                                if (responseStatus == 200) {
                                  setState(() {
                                    loading = false;
                                  });
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                  Functions.showCustomSnackBar(
                                    context: context,
                                    text: 'The given data was invalid!',
                                    hasIcon: true,
                                    iconType: Icons.error_outline,
                                    iconColor: Colors.red,
                                  );
                                }
                              } catch (err) {
                                print(err);
                                setState(() {
                                  loading = false;
                                });
                                Functions.showCustomSnackBar(
                                  context: context,
                                  text: 'The given data  invalid!',
                                  hasIcon: true,
                                  iconType: Icons.error_outline,
                                  iconColor: Colors.red,
                                );
                              }

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
