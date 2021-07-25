import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/data/signupModels/awards_model.dart';
import 'package:reaaia/data/signupModels/certifications_model.dart';
import 'package:reaaia/data/signupModels/complete_reg2_model.dart';
import 'package:reaaia/data/signupModels/languages_model.dart';
import 'package:reaaia/model/app_data/details.dart';
import 'package:reaaia/screens/auth/signup/compelete_reg3.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/data_provider.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';
import 'package:reaaia/viewModels/sign_up_provider.dart';
import 'package:path/path.dart' as path;

class CompleteRegister2 extends StatefulWidget {
  @override
  _CompleteRegister2State createState() => _CompleteRegister2State();
}

class _CompleteRegister2State extends State<CompleteRegister2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _addSubSpecialityController = TextEditingController();

  List<MainModel> _dynamicChips = [];
  List<int> _filters = [];

  String selectedScientificDegree;
  String selectedLanguage;
  String selectedLevelLanguage;

  bool isSelectedScientificDegree = false;
  bool isSelectedSpeciality = false;
  bool isSelectedSubSpeciality = false;

  File licenceImage;
  List<File> certificateImage = [];
  List<File> awardImage = [];
  CompleteReg2Model _completeReg2Model = CompleteReg2Model();
  List<Languages> _languages = [];
  List<Certifications> _certifications = [];
  List<Awards> _awards = [];

  List<TextEditingController> _controllersCertificationName = [];
  List<TextEditingController> _controllersCertificationYear = [];

  @override
  void initState() {
    super.initState();
    _languages.add(Languages());
    _controllersCertificationName.add(TextEditingController());
    _controllersCertificationYear.add(TextEditingController());
    _certifications.add(Certifications());
    certificateImage.add(null);
    _awards.add(Awards());
    awardImage.add(null);
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder borderScientificDegree = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: isSelectedScientificDegree
                ? ColorsUtils.onBoardingTextGrey
                : ColorsUtils.borderColor));

    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorsUtils.borderColor));
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Builder(
        builder: (context) =>
            Consumer<DataProvider>(builder: (_, provider, __) {
          final providerData = provider.appDataModel.response.data;
          return Form(
            key: _formKey,
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                color: ColorsUtils.blueColor,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    Row(
                      children: [
                        Text(
                         AppLocalizations.of(context).translate('education'),
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
                            AppLocalizations.of(context).translate('profileReg1Desc'),
                            style: TextStyle(
                                color: ColorsUtils.onBoardingTextGrey,
                                fontSize: ScreenUtil().setSp(13)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),

                    /// Scientific Degree
                    DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context).translate('scientificDegreeValidate');
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate('scientificDegree'),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(15)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        border: border,
                        disabledBorder: borderScientificDegree,
                        enabledBorder: borderScientificDegree,
                        errorBorder: borderScientificDegree,
                        focusedBorder: borderScientificDegree,
                        focusedErrorBorder: borderScientificDegree,
                        fillColor: Colors.white,
                        filled: !isSelectedScientificDegree,
                      ),
                      style: TextStyle(
                          color: ColorsUtils.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenUtil().setSp(16)),
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      isExpanded: true,
                      value: selectedScientificDegree,
                      iconSize: 24,
                      onChanged: (newValue) {
                        setState(() {
                          selectedScientificDegree = newValue;
                          isSelectedScientificDegree = true;
                        });
                      },
                      onSaved: (val) {
                        MainModel scientificDegreeModel = providerData
                            .scientificDegrees
                            .firstWhere((element) => element.name == val);
                        _completeReg2Model.scientificDegree =
                            scientificDegreeModel.id;
                      },
                      items: providerData.scientificDegrees
                          .map<DropdownMenuItem<String>>((MainModel value) {
                        return new DropdownMenuItem(
                          child: new Text(value.name),
                          value: value.name,
                        );
                      }).toList(),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24),
                              topLeft: Radius.circular(24),
                            )),
                            barrierColor: ColorsUtils.modalSheetBarrierColor,
                            backgroundColor: ColorsUtils.modalSheetBarrierColor,
                            context: context,
                            //isScrollControlled: true,
                            builder: (context) {
                              return Scaffold(
                                body: Container(
                                  width: ScreenUtil().screenWidth,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 40.0, horizontal: 25.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(24.0),
                                      topLeft: Radius.circular(24.0),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).translate('selectSpecialty'),
                                        style: TextStyle(
                                            color:
                                                ColorsUtils.onBoardingTextGrey,
                                            fontSize: ScreenUtil().setSp(16)),
                                      ),
                                      Text(
                                        AppLocalizations.of(context).translate('selectOneSpecialty'),
                                        style: TextStyle(
                                            color:
                                                ColorsUtils.onBoardingTextGrey,
                                            fontSize: ScreenUtil().setSp(13)),
                                      ),
                                      SizedBox(
                                          height: ScreenUtil().setHeight(20)),
                                      Flexible(
                                        child: ListView.builder(
                                            itemCount: providerData
                                                .specialities.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    _filters.clear();
                                                    _controller.text =
                                                        providerData
                                                            .specialities[index]
                                                            .name;
                                                    _dynamicChips = providerData
                                                        .specialities[index]
                                                        .subspecialities;
                                                    isSelectedSpeciality = true;
                                                  });

                                                  Navigator.pop(context);
                                                },
                                                leading: Container(
                                                    height: ScreenUtil()
                                                        .setHeight(40),
                                                    width: ScreenUtil()
                                                        .setWidth(40),
                                                    padding:
                                                        EdgeInsets.all(7.0),
                                                    decoration: BoxDecoration(
                                                      color: ColorsUtils
                                                          .primaryGreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: SvgPicture.asset(
                                                        'assets/icons/ic_allergiesonly.svg')),
                                                title: Text(
                                                  providerData
                                                      .specialities[index].name,
                                                  style: TextStyle(
                                                    fontSize:
                                                        ScreenUtil().setSp(15),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: IgnorePointer(
                        child: CustomTextField(
                          controller: _controller,
                          readOnly: true,
                          filledColor:
                              isSelectedSpeciality ? null : Colors.white,
                          lablel: AppLocalizations.of(context).translate('selectSpecialty'),
                          style: TextStyle(
                              color: ColorsUtils.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(16)),
                          hasBorder: true,
                          onSaved: (val) {
                            Specialities specialtyModel = providerData
                                .specialities
                                .firstWhere((element) => element.name == val);
                            _completeReg2Model.specialityId = specialtyModel.id;
                          },
                          //onSaved: (val) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context).translate('fieldRequiredValidate');
                            }
                            return null;
                          },
                          sufficIcon: Icon(Icons.keyboard_arrow_down_rounded),
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(15)),
                    Divider(
                      color: ColorsUtils.lineColor,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),

                    /// SubSpecialty
                    Text(
                      AppLocalizations.of(context).translate('selectSubSpecialty'),
                      style: TextStyle(
                          color: ColorsUtils.textGrey,
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(16)),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    _dynamicChips.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                                child: Text(AppLocalizations.of(context).translate('notSelectedSpecialty'),)),
                          )
                        : Wrap(
                            spacing: 10.0,
                            runSpacing: 6.0,
                            children: List<Widget>.generate(
                                _dynamicChips.length, (int index) {
                              bool checkContain =
                                  _filters.contains(_dynamicChips[index].id);
                              return InputChip(
                                showCheckmark: false,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(
                                    color: checkContain
                                        ? ColorsUtils.blueColor
                                        : ColorsUtils.onBoardingTextGrey,
                                  ),
                                ),
                                label: Text(_dynamicChips[index].name),
                                labelStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w600,
                                  color: checkContain
                                      ? Colors.white
                                      : ColorsUtils.textGrey,
                                ),
                                deleteIconColor: Colors.white,
                                deleteIcon: checkContain
                                    ? null
                                    : Icon(
                                        Icons.add,
                                        color: ColorsUtils.blueColor,
                                      ),
                                backgroundColor: ColorsUtils.greyColor,
                                selectedColor: ColorsUtils.blueColor,
                                selected: checkContain,
                                selectedShadowColor: null,
                                onDeleted: () {},
                                onSelected: (val) {
                                  setState(() {
                                    if (val) {
                                      _filters.add(_dynamicChips[index].id);
                                      _completeReg2Model
                                          .existingSubspecialities = _filters;
                                    } else {
                                      _filters.removeWhere((int name) {
                                        return name == _dynamicChips[index].id;
                                      });
                                      _completeReg2Model
                                          .existingSubspecialities = _filters;
                                    }
                                    print(_completeReg2Model
                                        .existingSubspecialities
                                        .toString());
                                  });
                                },
                              );
                            }),
                          ),
                    SizedBox(height: ScreenUtil().setHeight(10)),

                    Container(
                      height: ScreenUtil().setHeight(35),
                      width: ScreenUtil().setWidth(200.0),
                      child: InputChip(
                        padding: EdgeInsets.zero,
                        showCheckmark: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: ColorsUtils.onBoardingTextGrey,
                          ),
                        ),
                        avatar: false
                            ? null
                            : Icon(
                                Icons.add,
                                color: ColorsUtils.blueColor,
                              ),
                        label: TextFormField(
                          controller: _addSubSpecialityController,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (val) {
                            setState(() {
                              //_dynamicChips.add(val.);
                              _completeReg2Model.newSubspecialities.first = val;
                              _addSubSpecialityController.clear();
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 12.0),
                            hintText: AppLocalizations.of(context).translate('addOtherSpecialty'),
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onSaved: (val) {
                            _completeReg2Model.newSubspecialities = [];
                            _addSubSpecialityController.clear();
                          },
                        ),
                        labelStyle: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w600,
                          color: false ? Colors.white : ColorsUtils.textGrey,
                        ),
                        deleteIconColor: Colors.white,
                        deleteIcon: true
                            ? null
                            : Icon(
                                Icons.add,
                                color: ColorsUtils.blueColor,
                              ),
                        backgroundColor: ColorsUtils.greyColor,
                        selectedColor: ColorsUtils.blueColor,
                        //selected: checkContain,
                        selectedShadowColor: null,
                        onDeleted: true ? null : () {},
                        onSelected: (val) {},
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    Divider(
                      color: ColorsUtils.lineColor,
                    ),

                    /// //////////////////////////
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    InkWell(
                      onTap: () async {
                        final pickedImage = await Functions.pickImage();
                        if (pickedImage != null) {
                          setState(() {
                            licenceImage = pickedImage;
                          });
                          try {
                            await signUpProvider.uploadPicture(
                                collection: 'Doctor license image',
                                file: licenceImage);
                            if (signUpProvider.tokenPicture != null) {
                              _completeReg2Model.practiceLicenceImage = [
                                signUpProvider.tokenPicture
                              ];
                              print(
                                  'we found token ${signUpProvider.tokenPicture}');
                              Functions.showCustomSnackBar(
                                context: context,
                                text: AppLocalizations.of(context).translate('picLoadSuccessfully'),
                                hasIcon: true,
                                iconType: Icons.done,
                                iconColor: Colors.green,
                              );
                            } else {
                              Functions.showCustomSnackBar(
                                context: context,
                                text: AppLocalizations.of(context).translate('picLoadFailed'),
                                hasIcon: true,
                                iconType: Icons.error_outline,
                                iconColor: Colors.red,
                              );
                            }
                          } catch (err) {
                            Functions.showCustomSnackBar(
                              context: context,
                              text: AppLocalizations.of(context).translate('picLoadFailed'),
                              hasIcon: true,
                              iconType: Icons.error_outline,
                              iconColor: Colors.red,
                            );
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
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: ScreenUtil().setWidth(24),
                              height: ScreenUtil().setHeight(24),
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: SvgPicture.asset(
                                'assets/icons/fi-rr-cloud-upload.svg',
                                color: ColorsUtils.blueColor,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                licenceImage != null
                                    ? path.basename(licenceImage.path)
                                    : AppLocalizations.of(context).translate('image_licence'),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenUtil().setSp(12),
                                    color: ColorsUtils.textGrey),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(15)),
                    CustomTextField(
                      filledColor: Colors.white,
                      lablel: AppLocalizations.of(context).translate('grad_university'),
                      hasBorder: true,
                      onSaved: (val) {
                        _completeReg2Model.university = val;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context).translate('fieldRequiredValidate');
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    Divider(
                      color: ColorsUtils.lineColor,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),

                    /// language
                    Container(
                      width: ScreenUtil().screenWidth,
                      //height: ScreenUtil().setHeight(250),
                      padding: EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).translate('lang'),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(16),
                                color: ColorsUtils.primaryGreen),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: _languages.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SizedBox(height: ScreenUtil().setHeight(16)),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Language',
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: ScreenUtil().setSp(15)),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      border: border,
                                      disabledBorder: border,
                                      enabledBorder: border,
                                      errorBorder: border,
                                      focusedBorder: border,
                                      focusedErrorBorder: border,
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    style: TextStyle(
                                        color: ColorsUtils.blackColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(16)),
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    isExpanded: true,
                                    //value: selectedLanguage[index],
                                    iconSize: 24,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedLanguage = newValue;
                                        // print(selectedLanguage.toString());
                                      });
                                    },
                                    onSaved: (val) {
                                      MainModel models = providerData.languages
                                          .firstWhere(
                                              (element) => element.name == val);
                                      print(val + '  ' + models.id.toString());
                                      _languages[index].languageId = models.id;
                                    },
                                    items: providerData.languages
                                        .map<DropdownMenuItem<String>>(
                                            (MainModel value) {
                                      return new DropdownMenuItem(
                                        child: new Text(value.name),
                                        value: value.name,
                                      );
                                    }).toList(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context).translate('fieldRequiredValidate');
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context).translate('levelOfLang'),
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: ScreenUtil().setSp(15)),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      border: border,
                                      disabledBorder: border,
                                      enabledBorder: border,
                                      errorBorder: border,
                                      focusedBorder: border,
                                      focusedErrorBorder: border,
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    style: TextStyle(
                                        color: ColorsUtils.blackColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(16)),
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    isExpanded: true,
                                    //value: selectedLevelLanguage,
                                    iconSize: 24,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedLevelLanguage = newValue;
                                      });
                                    },
                                    onSaved: (val) {
                                      MainModel models = providerData
                                          .languageLevels
                                          .firstWhere(
                                              (element) => element.name == val);
                                      print(val + '  ' + models.id.toString());
                                      _languages[index].languageLevelId =
                                          models.id;
                                    },
                                    items: providerData.languageLevels
                                        .map<DropdownMenuItem<String>>(
                                            (MainModel value) {
                                      return new DropdownMenuItem(
                                        child: new Text(value.name),
                                        value: value.name,
                                      );
                                    }).toList(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context).translate('fieldRequiredValidate');
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(20),
                                  ),
                                ],
                              );
                            },
                          ),
                          Container(
                            height: ScreenUtil().setHeight(50),
                            child: CustomRoundedButton(
                              iconLeft: true,
                              backgroundColor: ColorsUtils.buttonColorLight,
                              borderColor: ColorsUtils.buttonColorLight,
                              icon: Icon(
                                Icons.add,
                                color: ColorsUtils.primaryGreen,
                              ),
                              text: AppLocalizations.of(context).translate('addMoreLang'),
                              pressed: () {
                                setState(() {
                                  _languages.add(Languages());
                                });
                              },
                              textColor: ColorsUtils.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),

                    /// Certification
                    Container(
                      width: ScreenUtil().screenWidth,
                      padding: EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).translate('certification'),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(16),
                                color: ColorsUtils.primaryGreen),
                          ),
                          ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _certifications.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                        height: ScreenUtil().setHeight(16)),
                                    CustomTextField(
                                      filledColor: Colors.white,
                                      lablel: AppLocalizations.of(context).translate('certificateName'),
                                      hasBorder: true,
                                      onSaved: (val) {
                                        _certifications[index].name = val;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppLocalizations.of(context).translate('fieldRequiredValidate');
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        _certifications[index].name = val;
                                      },
                                    ),
                                    SizedBox(
                                        height: ScreenUtil().setHeight(20)),
                                    CustomTextField(
                                      filledColor: Colors.white,
                                      lablel: AppLocalizations.of(context).translate('year'),
                                      hasBorder: true,
                                      onSaved: (val) {
                                        _certifications[index].year = val;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppLocalizations.of(context).translate('fieldRequiredValidate');
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        _certifications[index].year = val;
                                      },
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(20),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final pickedImage =
                                            await Functions.pickImage();
                                        if (pickedImage != null) {
                                          setState(() {
                                            certificateImage[index] =
                                                pickedImage;
                                          });
                                          try {
                                            await signUpProvider.uploadPicture(
                                                collection:
                                                    'Doctor certification images',
                                                file: certificateImage[index]);
                                            if (signUpProvider.tokenPicture !=
                                                null) {
                                              _certifications[index].image = [
                                                signUpProvider.tokenPicture
                                              ];
                                              print(jsonEncode(_certifications)
                                                  .toString());
                                              Functions.showCustomSnackBar(
                                                context: context,
                                                text:
                                                AppLocalizations.of(context).translate('picLoadSuccessfully'),
                                                hasIcon: true,
                                                iconType: Icons.done,
                                                iconColor: Colors.green,
                                              );
                                            } else {
                                              Functions.showCustomSnackBar(
                                                context: context,
                                                text: AppLocalizations.of(context).translate('picLoadFailed'),
                                                hasIcon: true,
                                                iconType: Icons.error_outline,
                                                iconColor: Colors.red,
                                              );
                                            }
                                          } catch (err) {
                                            Functions.showCustomSnackBar(
                                              context: context,
                                              text: AppLocalizations.of(context).translate('picLoadFailed'),
                                              hasIcon: true,
                                              iconType: Icons.error_outline,
                                              iconColor: Colors.red,
                                            );
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
                                                certificateImage[index] != null
                                                    ? path.basename(
                                                        certificateImage[index]
                                                            .path)
                                                    : AppLocalizations.of(context).translate('attachCertificatePic'),
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
                                  ],
                                );
                              }),
                          Container(
                            height: ScreenUtil().setHeight(50),
                            child: CustomRoundedButton(
                              iconLeft: true,
                              backgroundColor: ColorsUtils.buttonColorLight,
                              borderColor: ColorsUtils.buttonColorLight,
                              icon: Icon(
                                Icons.add,
                                color: ColorsUtils.primaryGreen,
                              ),
                              text: AppLocalizations.of(context).translate('addMoreCert'),
                              pressed: () {
                                setState(() {
                                  _certifications.add(Certifications());
                                  certificateImage.add(null);
                                });
                              },
                              textColor: ColorsUtils.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),

                    /// award
                    Container(
                      width: ScreenUtil().screenWidth,
                      padding: EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).translate('awards'),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(16),
                                color: ColorsUtils.primaryGreen),
                          ),
                          ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _awards.length,
                              itemBuilder: (context, index) {
                                return Column(children: [
                                  SizedBox(height: ScreenUtil().setHeight(16)),
                                  CustomTextField(
                                    filledColor: Colors.white,
                                    lablel: AppLocalizations.of(context).translate('awardName'),
                                    hasBorder: true,
                                    onSaved: (val) {
                                      _awards[index].name = val;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context).translate('fieldRequiredValidate');
                                      }
                                      return null;
                                    },
                                    onChanged: (val){
                                      _awards[index].name = val;
                                    },
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  CustomTextField(
                                    filledColor: Colors.white,
                                    lablel: AppLocalizations.of(context).translate('year'),
                                    hasBorder: true,
                                    onSaved: (val) {
                                      _awards[index].year = val;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context).translate('fieldRequiredValidate');
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      _awards[index].year = val;
                                    },
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20),),
                                  InkWell(
                                    onTap: () async {
                                      final pickedImage = await Functions.pickImage();
                                      if (pickedImage != null) {
                                        setState(() {
                                          awardImage[index] = pickedImage;
                                        });
                                        try {
                                          await signUpProvider.uploadPicture(
                                              collection: 'Doctor award images',
                                              file: awardImage[index]);
                                          if (signUpProvider.tokenPicture != null) {
                                            _awards[index].image = [
                                              signUpProvider.tokenPicture
                                            ];
                                            print(jsonEncode(_awards)
                                                .toString());
                                            print(
                                                'we found token ${signUpProvider.tokenPicture}');
                                            Functions.showCustomSnackBar(
                                              context: context,
                                              text: AppLocalizations.of(context).translate('picLoadSuccessfully'),
                                              hasIcon: true,
                                              iconType: Icons.done,
                                              iconColor: Colors.green,
                                            );
                                          } else {
                                            Functions.showCustomSnackBar(
                                              context: context,
                                              text: AppLocalizations.of(context).translate('picLoadFailed'),
                                              hasIcon: true,
                                              iconType: Icons.error_outline,
                                              iconColor: Colors.red,
                                            );
                                          }
                                        } catch (err) {
                                          Functions.showCustomSnackBar(
                                            context: context,
                                            text: AppLocalizations.of(context).translate('picLoadFailed'),
                                            hasIcon: true,
                                            iconType: Icons.error_outline,
                                            iconColor: Colors.red,
                                          );
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
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey[300]),
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: ScreenUtil().setWidth(24),
                                            height: ScreenUtil().setHeight(24),
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
                                              awardImage[index] != null
                                                  ? path.basename(awardImage[index].path)
                                                  : AppLocalizations.of(context).translate('attachAwardPic'),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: ScreenUtil().setSp(13),
                                                  color: ColorsUtils.textGrey),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20),),

                                ]);
                              }),

                          Container(
                            height: ScreenUtil().setHeight(50),
                            child: CustomRoundedButton(
                              iconLeft: true,
                              backgroundColor: ColorsUtils.buttonColorLight,
                              borderColor: ColorsUtils.buttonColorLight,
                              icon: Icon(
                                Icons.add,
                                color: ColorsUtils.primaryGreen,
                              ),
                              text: AppLocalizations.of(context).translate('addMoreAward'),
                              pressed: () {
                                setState(() {
                                  _awards.add(Awards());
                                  awardImage.add(null);
                                });
                              },
                              textColor: ColorsUtils.primaryGreen,
                            ),
                          ),
                        ],
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
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          text: AppLocalizations.of(context).translate('continue'),
                          pressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              FocusManager.instance.primaryFocus.unfocus();
                              if (licenceImage != null &&
                                  certificateImage.isNotEmpty &&
                                  awardImage.isNotEmpty ) {
                                _completeReg2Model.languages = _languages;
                                _completeReg2Model.certifications =
                                    _certifications;
                                _completeReg2Model.awards = _awards;
                                Provider.of<SignUpProvider>(context,
                                        listen: false)
                                    .setCompleteReg2Model(_completeReg2Model);
                                CustomFunctions.pushScreen(
                                    context: context,
                                    widget: CompleteRegister3());
                              } else {
                                Functions.showCustomSnackBar(
                                  context: context,
                                  text: AppLocalizations.of(context).translate('allFieldsRequired'),
                                  hasIcon: false,
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
          );
        }),
      ),
    );
  }
}
