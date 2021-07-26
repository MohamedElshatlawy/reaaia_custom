import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/data/signupModels/complete_reg2_model.dart';
import 'package:reaaia/model/app_data/details.dart';
import 'package:reaaia/screens/auth/signup/compelete_reg3.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/home/profile/custom_view_image.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/data_provider.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';
import 'package:reaaia/viewModels/sign_up_provider.dart';
import 'package:path/path.dart' as path;

class EditEducationPage extends StatefulWidget {
  @override
  _EditEducationPageState createState() => _EditEducationPageState();
}

class _EditEducationPageState extends State<EditEducationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _addSubSpecialityController = TextEditingController();

  List<MainModel> _dynamicChips = [];
  List<int> _filters = [];

  String selectedScientificDegree = 'Consultant';
  String selectedLanguage;
  String selectedLevelLanguage;
  List<Specialities> _specialities;

  bool isSelectedScientificDegree = false;
  bool isSelectedSpeciality = false;
  bool isSelectedSubSpeciality = false;

  File licenceImage;
  CompleteReg2Model _completeReg2Model = CompleteReg2Model();

  @override
  void initState() {
    super.initState();
    _controller.text = 'Dentistry';
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
          _specialities = providerData.specialities
              .where((element) => element.name == _controller.text)
              .toList();
          _dynamicChips = _specialities.first.subspecialities;
          print(jsonEncode(_specialities));
          print(jsonEncode(_dynamicChips));
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
                          AppLocalizations.of(context).translate('editEducation'),
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
                          print(newValue);
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
                                                  print(providerData
                                                      .specialities[index]
                                                      .name);

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
                            contentPadding: EdgeInsets.only(bottom: 9.0),
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
                    Text(
                      AppLocalizations.of(context).translate('professionalLicence'),                      style: TextStyle(
                          color: ColorsUtils.textGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(16)),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(6)),
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
                          isScrollControlled: true,
                          builder: (context) {
                            return CustomViewImage(
                              image: 'assets/default-avatar.png',
                              btnRemoveName: AppLocalizations.of(context).translate('removeLicence'),
                              btnChangeName: AppLocalizations.of(context).translate('changeLicence'),
                              onChange: () {},
                              onRemove: () {},
                            );
                          },
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('viewLicence'),
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: ColorsUtils.blueColor,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(15)),
                      ),
                    ),

                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Divider(
                      color: ColorsUtils.lineColor,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
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

                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: ScreenUtil().setHeight(50),
                        width: 236,
                        child: CustomRoundedButton(
                          backgroundColor: ColorsUtils.primaryGreen,
                          borderColor: ColorsUtils.primaryGreen,
                          text: AppLocalizations.of(context).translate('save'),
                          pressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              FocusManager.instance.primaryFocus.unfocus();
                              if (licenceImage != null) {
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
