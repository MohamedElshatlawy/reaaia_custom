import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/model/clinics/add_service.dart';
import 'package:reaaia/model/clinics/service_model.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';

import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';
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
  bool imageLoaded=false;

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
                        AppLocalizations.of(context).translate('editService'),
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
                    lablel: AppLocalizations.of(context).translate('serviceName'),
                    hasBorder: true,
                    onSaved: (val) {
                      serviceName.en=val;
                      serviceName.ar=val;
                      _addServiceModel.name=serviceName;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context).translate('fieldRequiredValidate');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  CustomTextField(
                    initialValue: widget.serviceModel.description,
                    filledColor: Colors.white,
                    lablel: AppLocalizations.of(context).translate('serviceDescription'),
                    hasBorder: true,
                    onSaved: (val) {
                      serviceDesc.en=val;
                      serviceDesc.ar=val;
                      _addServiceModel.description=serviceDesc;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context).translate('fieldRequiredValidate');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  CustomTextField(
                    initialValue: widget.serviceModel.requirements,
                    filledColor: Colors.white,
                    lablel: AppLocalizations.of(context).translate('serviceReq'),
                    hasBorder: true,
                    onSaved: (val) {
                      serviceReq.en=val;
                      serviceReq.ar=val;
                      _addServiceModel.requirements=serviceReq;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context).translate('fieldRequiredValidate');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  CustomTextField(
                    initialValue: widget.serviceModel.price,
                    filledColor: Colors.white,
                    lablel: AppLocalizations.of(context).translate('serviceCost'),
                    hasBorder: true,
                    onSaved: (val) {
                      _addServiceModel.price=double.tryParse(val).toInt();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context).translate('fieldRequiredValidate');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  CustomTextField(
                    initialValue: widget.serviceModel.discountPercentage.toString(),
                    filledColor: Colors.white,
                    lablel: AppLocalizations.of(context).translate('discount'),
                    hasBorder: true,
                    onSaved: (val) {
                      _addServiceModel.discountPercentage=int.tryParse(val);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context).translate('fieldRequiredValidate');
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
                          imageLoaded=true;
                        });

                        try{
                          await  clinicProvider.uploadServiceImages(collection: 'clinic-service-images',files: imagesFiles);
                          if( clinicProvider.tokenImages!=null){

                            _addServiceModel.files=[clinicProvider.tokenImages];
                            print('we found token ${clinicProvider.tokenImages.toString()}');
                            Functions.showCustomSnackBar(
                              context: context,
                              text: AppLocalizations.of(context).translate('picLoadSuccessfully'),
                              hasIcon: true,
                              iconType: Icons.done,
                              iconColor: Colors.green,
                            );
                            setState(() {
                              imageLoaded=false;
                            });
                          }else{
                            Functions.showCustomSnackBar(
                              context: context,
                              text: AppLocalizations.of(context).translate('picLoadFailed'),
                              hasIcon: true,
                              iconType: Icons.error_outline,
                              iconColor: Colors.red,
                            );
                            setState(() {
                              imageLoaded=false;
                            });
                          }
                        }catch(err){
                          Functions.showCustomSnackBar(
                            context: context,
                            text: AppLocalizations.of(context).translate('picLoadFailed'),
                            hasIcon: true,
                            iconType: Icons.error_outline,
                            iconColor: Colors.red,
                          );
                          setState(() {
                            imageLoaded=false;
                          });
                        }
                      } else {
                        Functions.showCustomSnackBar(
                          context: context,
                          text: AppLocalizations.of(context).translate('picLoadFailed'),
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
                                  :AppLocalizations.of(context).translate('uploadImages'),
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
                  imageLoaded?  Center(child: Text(AppLocalizations.of(context).translate('uploadingImage'),)) : loading?Center(child: CircularProgressIndicator()):   Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: ScreenUtil().setHeight(50),
                      width: 236,
                      child: CustomRoundedButton(
                        backgroundColor: ColorsUtils.primaryGreen,
                        borderColor: ColorsUtils.primaryGreen,
                        text: AppLocalizations.of(context).translate('save'),
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
                                    text: AppLocalizations.of(context).translate('error'),
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
                                  text: 'Server Error $err',
                                  hasIcon: true,
                                  iconType: Icons.error_outline,
                                  iconColor: Colors.red,
                                );
                              }

                            }else{

                              Functions.showCustomSnackBar(
                                context: context,
                                text: AppLocalizations.of(context).translate('allFieldsRequired'),
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
