import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/model/app_data/details.dart';
import 'package:reaaia/model/data/signup/clinic_address_model.dart';
import 'package:reaaia/model/data/signup/owned_clinic_model.dart';
import 'package:reaaia/screens/auth/signup/complete_req1_map.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/data_provider.dart';
import 'package:reaaia/viewModels/sign_up_provider.dart';

class ClinicInfoPage extends StatefulWidget {
  @override
  _ClinicInfoPageState createState() => _ClinicInfoPageState();
}

class _ClinicInfoPageState extends State<ClinicInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _addSubSpecialityController = TextEditingController();
  TextEditingController _addOtherPlanController = TextEditingController();
  TextEditingController _mapController = TextEditingController();

  File image;

  String selectedCity;
  String selectedCityArea;
  bool isSelectedSpeciality = false;
  bool isSelectedSubSpeciality = false;
  String hospitalName;

  String jobTitle;

  String startForm;
  DateTime pickedDataStartFrom;
  LatLng _latLng;

  List<MainModel> _dynamicChips = [];
  List<int> _filters = [];

  List<Areas> _areas = [];
  List<int> _filters2 = [];

  List<TextEditingController> _textFieldControllers = [];

  int counterPhoneNumbers = 1;
  List<String> phoneNumbersList = [];

  OwnedClinic ownedClinic = OwnedClinic();
  ClinicAddress clinicAddress = ClinicAddress();

  @override
  void initState() {
    super.initState();
    _textFieldControllers.add(TextEditingController());
    _controller.text='hello';
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorsUtils.borderColor));
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Builder(builder: (context) {
        return Consumer<DataProvider>(
          builder: (_, provider, __) {
            final providerData = provider.appDataModel.response.data;
            return Form(
              key: _formKey,
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ScreenUtil().setHeight(48)),
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
                      SizedBox(height: ScreenUtil().setHeight(17)),
                      Row(
                        children: [
                          Text(
                            'Clinic Info',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: ScreenUtil().setSp(24)),
                          ),
                        ],
                      ),
                      /// upload photo
                      SizedBox(height: ScreenUtil().setHeight(17)),
                      Consumer<SignUpProvider>(
                        builder: (_, signUpProvider, __) => Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                    width: ScreenUtil().setWidth(89),
                                    height: ScreenUtil().setHeight(89),
                                    //padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.grey[300]),
                                        borderRadius:
                                            BorderRadius.circular(17)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(17),
                                      child: image != null
                                          ? Image.file(
                                              image,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/default-avatar.png',
                                              fit: BoxFit.cover,
                                            ),
                                    )),
                                if (image != null)
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          image = null;
                                          //_completeReg1Model.avatarImage.clear();
                                        });

                                        Functions.showCustomSnackBar(
                                          context: context,
                                          text: 'Picture Remove Successfully',
                                          hasIcon: true,
                                          iconType: Icons.done,
                                          iconColor: Colors.green,
                                        );
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey[300]),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.red,
                                            size: 16,
                                          )),
                                    ),
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
                                      pressed: () async {
                                        final pickedImage =
                                            await Functions.pickImage();
                                        if (pickedImage != null) {
                                          setState(() {
                                            image = pickedImage;
                                          });
                                          try {
                                            await signUpProvider.uploadPicture(
                                                collection:
                                                    'Doctor avatar image',
                                                file: image);
                                            if (signUpProvider.tokenPicture !=
                                                null) {
                                              //_completeReg1Model.avatarImage=[signUpProvider.tokenPicture];
                                              print(
                                                  'we found token ${signUpProvider.tokenPicture}');
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
                                      textColor: Colors.white,
                                    ),
                                    SizedBox(
                                        height: ScreenUtil().setHeight(12)),
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
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Hospital / Clinic Name
                          CustomTextField(
                            initialValue: 'Diamond Clinic for Skin care',
                            lablel: ' Hospital / Clinic Name',
                            hasBorder: true,
                            onSaved: (val) {
                              ownedClinic.clinicName = val;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This Field Required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                              height: ScreenUtil().setHeight(20)),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  clipBehavior:
                                  Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(24),
                                        topLeft: Radius.circular(24),
                                      )),
                                  barrierColor: ColorsUtils
                                      .modalSheetBarrierColor,
                                  backgroundColor: ColorsUtils
                                      .modalSheetBarrierColor,
                                  context: context,
                                  //isScrollControlled: true,
                                  builder: (context) {
                                    return Scaffold(
                                      body: Container(
                                        width:
                                        ScreenUtil().screenWidth,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 40.0,
                                            horizontal: 25.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.only(
                                            topRight:
                                            Radius.circular(24.0),
                                            topLeft:
                                            Radius.circular(24.0),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              'Select Speciality',
                                              style: TextStyle(
                                                  color: ColorsUtils
                                                      .onBoardingTextGrey,
                                                  fontSize:
                                                  ScreenUtil()
                                                      .setSp(16)),
                                            ),
                                            Text(
                                              'you can select only one Speciality',
                                              style: TextStyle(
                                                  color: ColorsUtils
                                                      .onBoardingTextGrey,
                                                  fontSize:
                                                  ScreenUtil()
                                                      .setSp(13)),
                                            ),
                                            SizedBox(
                                                height: ScreenUtil()
                                                    .setHeight(20)),
                                            Flexible(
                                              child: ListView.builder(
                                                  itemCount:
                                                  providerData
                                                      .specialities
                                                      .length,
                                                  itemBuilder:
                                                      (context,
                                                      index) {
                                                    return ListTile(
                                                      onTap: () {
                                                        setState(() {
                                                          _filters
                                                              .clear();
                                                          _controller
                                                              .text =
                                                              providerData
                                                                  .specialities[index]
                                                                  .name;
                                                          _dynamicChips = providerData
                                                              .specialities[
                                                          index]
                                                              .subspecialities;
                                                          isSelectedSpeciality =
                                                          true;
                                                        });

                                                        Navigator.pop(
                                                            context);
                                                      },
                                                      leading:
                                                      Container(
                                                          height: ScreenUtil().setHeight(
                                                              40),
                                                          width: ScreenUtil().setWidth(
                                                              40),
                                                          padding:
                                                          EdgeInsets.all(
                                                              7.0),
                                                          decoration:
                                                          BoxDecoration(
                                                            color:
                                                            ColorsUtils.primaryGreen,
                                                            borderRadius:
                                                            BorderRadius.circular(8.0),
                                                          ),
                                                          child: SvgPicture.asset(
                                                              'assets/icons/ic_allergiesonly.svg')),
                                                      title: Text(
                                                        providerData
                                                            .specialities[
                                                        index]
                                                            .name,
                                                        style:
                                                        TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(
                                                              15),
                                                          fontWeight:
                                                          FontWeight
                                                              .w600,
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
                                filledColor: isSelectedSpeciality
                                    ? null
                                    : Colors.white,
                                lablel: ' Select Specialty*',
                                style: TextStyle(
                                    color: ColorsUtils.blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenUtil().setSp(16)),
                                hasBorder: true,
                                onSaved: (val) {
                                  Specialities specialtyModel =
                                  providerData.specialities
                                      .firstWhere((element) =>
                                  element.name == val);
                                  ownedClinic.clinicSpeclialityId =
                                      specialtyModel.id;
                                  print(ownedClinic
                                      .clinicSpeclialityId
                                      .toString());
                                },
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty) {
                                    return 'This Field Required';
                                  }
                                  return null;
                                },
                                sufficIcon: Icon(Icons
                                    .keyboard_arrow_down_rounded),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: ScreenUtil().setHeight(15)),
                          Divider(
                            color: ColorsUtils.lineColor,
                          ),

                          /// SubSpecialty
                          Text(
                            'Select SubSpecialty ',
                            style: TextStyle(
                                color: ColorsUtils.textGrey,
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenUtil().setSp(16)),
                          ),
                          SizedBox(
                              height: ScreenUtil().setHeight(20)),
                          _dynamicChips.isEmpty
                              ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                                child: Text(
                                    'Not Specialty Selected yet!')),
                          )
                              : Wrap(
                            spacing: 10.0,
                            runSpacing: 6.0,
                            children: List<Widget>.generate(
                                _dynamicChips.length,
                                    (int index) {
                                  bool checkContain =
                                  _filters.contains(
                                      _dynamicChips[index].id);
                                  return InputChip(
                                    showCheckmark: false,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      side: BorderSide(
                                        color: checkContain
                                            ? ColorsUtils.blueColor
                                            : ColorsUtils
                                            .onBoardingTextGrey,
                                      ),
                                    ),
                                    label: Text(
                                        _dynamicChips[index].name),
                                    labelStyle: TextStyle(
                                      fontSize:
                                      ScreenUtil().setSp(14),
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
                                      color: ColorsUtils
                                          .blueColor,
                                    ),
                                    backgroundColor:
                                    ColorsUtils.greyColor,
                                    selectedColor:
                                    ColorsUtils.blueColor,
                                    selected: checkContain,
                                    selectedShadowColor: null,
                                    onDeleted: () {},
                                    onSelected: (val) {
                                      setState(() {
                                        if (val) {
                                          _filters.add(
                                              _dynamicChips[index]
                                                  .id);
                                          ownedClinic
                                              .existingSubspecialities =
                                              _filters;
                                        } else {
                                          _filters.removeWhere(
                                                  (int name) {
                                                return name ==
                                                    _dynamicChips[index]
                                                        .id;
                                              });
                                          ownedClinic
                                              .existingSubspecialities =
                                              _filters;
                                        }
                                        print(ownedClinic
                                            .existingSubspecialities
                                            .toString());
                                      });
                                    },
                                  );
                                }),
                          ),
                          SizedBox(
                              height: ScreenUtil().setHeight(10)),
                          Container(
                            height: ScreenUtil().setHeight(35),
                            width: ScreenUtil().setWidth(200.0),
                            child: InputChip(
                              padding: EdgeInsets.zero,
                              showCheckmark: false,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(8.0),
                                side: BorderSide(
                                  color:
                                  ColorsUtils.onBoardingTextGrey,
                                ),
                              ),
                              avatar: false
                                  ? null
                                  : Icon(
                                Icons.add,
                                color: ColorsUtils.blueColor,
                              ),
                              label: TextFormField(
                                controller:
                                _addSubSpecialityController,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (val) {
                                  setState(() {
                                    // _dynamicChips.add(val);
                                    _addSubSpecialityController
                                        .clear();
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(bottom: 12.0),
                                  hintText: 'Add Other Specialty',
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusedErrorBorder:
                                  InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                onSaved: (val) {
                                  ownedClinic.newSubspecialities = [];
                                },
                              ),
                              labelStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w600,
                                color: false
                                    ? Colors.white
                                    : ColorsUtils.textGrey,
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

                          /// address and city
                          SizedBox(
                              height: ScreenUtil().setHeight(20)),
                          Row(
                            children: [
                              Expanded(
                                child:
                                DropdownButtonFormField<String>(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty) {
                                      return ' Select City!';
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'City',
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                        ScreenUtil().setSp(15)),
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 5.0),
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
                                      fontSize:
                                      ScreenUtil().setSp(16)),
                                  icon: const Icon(Icons
                                      .keyboard_arrow_down_outlined),
                                  isExpanded: true,
                                  value: selectedCity,
                                  iconSize: 24,
                                  onChanged: (newValue) {
                                    setState(() {
                                      //_areas.clear();
                                      selectedCityArea = null;
                                      selectedCity = newValue;
                                      Cities cityModel = providerData
                                          .cities
                                          .firstWhere((element) =>
                                      element.name ==
                                          newValue);
                                      _areas = cityModel.areas;
                                      print(newValue +
                                          '  ' +
                                          cityModel.id.toString());
                                    });
                                  },
                                  onSaved: (val) {
                                    Cities cityModel = providerData
                                        .cities
                                        .firstWhere((element) =>
                                    element.name == val);
                                    clinicAddress.cityId =
                                        cityModel.id;
                                    print(clinicAddress.cityId
                                        .toString());
                                    //ownedClinic
                                  },
                                  items: providerData.cities
                                      .map<DropdownMenuItem<String>>(
                                          (Cities value) {
                                        return new DropdownMenuItem(
                                          child: new Text(value.name),
                                          value: value.name,
                                        );
                                      }).toList(),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(25.0),
                              ),
                              Expanded(
                                child:
                                DropdownButtonFormField<String>(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty) {
                                      return ' Select Area!';
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Area',
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                        ScreenUtil().setSp(15)),
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 5.0),
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
                                      fontSize:
                                      ScreenUtil().setSp(16)),
                                  icon: const Icon(Icons
                                      .keyboard_arrow_down_outlined),
                                  isExpanded: true,
                                  value: selectedCityArea,
                                  iconSize: 24,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCityArea = newValue;
                                      print(selectedCityArea);
                                      Areas areaModel = _areas
                                          .firstWhere((element) =>
                                      element.name ==
                                          newValue);
                                      clinicAddress.areaId =
                                          areaModel.id;
                                      print(clinicAddress.areaId
                                          .toString());
                                    });
                                  },
                                  items: _areas
                                      .map<DropdownMenuItem<String>>(
                                          (Areas value) {
                                        return new DropdownMenuItem(
                                          child: new Text(value.name),
                                          value: value.name,
                                        );
                                      }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(15),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          CompleteRequest1Map()))
                                  .then((value) {
                                setState(() {
                                  _latLng = value as LatLng;
                                  print(value.toString());
                                  _mapController.text = 'Lat:' +
                                      _latLng.latitude
                                          .toStringAsFixed(2) +
                                      ' Lng:' +
                                      _latLng.longitude
                                          .toStringAsFixed(2);
                                  clinicAddress.latitude =
                                      _latLng.latitude;
                                  clinicAddress.longitude =
                                      _latLng.longitude;
                                  clinicAddress.detailedAddress =
                                  'testttttt1';
                                });
                              });
                            },
                            child: IgnorePointer(
                              child: CustomTextField(
                                controller: _mapController,
                                filledColor: Colors.white,
                                lablel: ' Main Address*',
                                hasBorder: true,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty) {
                                    return 'This Field Required';
                                  }
                                  return null;
                                },
                                icon: Icon(
                                  Icons.location_on_outlined,
                                  color: ColorsUtils.blueColor,
                                ),
                                sufficIcon: Icon(
                                  Icons.my_location,
                                  color:
                                  ColorsUtils.onBoardingTextGrey,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: ScreenUtil().setHeight(20)),
                          Divider(
                            color: ColorsUtils.lineColor,
                          ),
                          //SizedBox(height: ScreenUtil().setHeight(20)),

                          /// phone number

                          ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: counterPhoneNumbers,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5.0),
                                child: CustomTextField(
                                  controller:
                                  _textFieldControllers[index],
                                  onChanged: (val) {
                                    setState(() {
                                      phoneNumbersList.clear();
                                      _textFieldControllers.map((e) {
                                        phoneNumbersList.add(e.text);
                                      }).toList();
                                      print(
                                          ' my list numbers ${phoneNumbersList.toString()}');
                                      // ownedClinic.clinicPhoneNumbers=phoneNumbersList;
                                    });
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      phoneNumbersList.clear();
                                      _textFieldControllers.map((e) {
                                        phoneNumbersList.add(e.text);
                                      }).toList();
                                      print(
                                          ' my list numbers ${phoneNumbersList.toString()}');
                                      ownedClinic.clinicPhoneNumbers =
                                          phoneNumbersList;
                                    });
                                  },
                                  filledColor: Colors.white,
                                  lablel: ' Phone Number*',
                                  hasBorder: true,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty) {
                                      return 'This Field Required';
                                    } else if (value.length != 11) {
                                      return 'this Field Should no less than 11 digits';
                                    }
                                    return null;
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(
                              height: ScreenUtil().setHeight(10)),
                          Container(
                            height: ScreenUtil().setHeight(40),
                            child: CustomRoundedButton(
                              iconLeft: true,
                              backgroundColor:
                              ColorsUtils.buttonColorLight,
                              borderColor:
                              ColorsUtils.buttonColorLight,
                              icon: Icon(
                                Icons.add,
                                color: ColorsUtils.primaryGreen,
                              ),
                              text: 'Add More Phone Numbers ',
                              pressed: () {
                                setState(() {
                                  _textFieldControllers
                                      .add(TextEditingController());
                                  counterPhoneNumbers += 1;
                                });
                              },
                              textColor: ColorsUtils.primaryGreen,
                            ),
                          ),

                          SizedBox(
                              height: ScreenUtil().setHeight(20)),
                          Divider(
                            color: ColorsUtils.lineColor,
                          ),
                          SizedBox(
                              height: ScreenUtil().setHeight(20)),

                          /// Accepted Insurance Plans
                          Text(
                            'Accepted Insurance Plans',
                            style: TextStyle(
                                color: ColorsUtils.textGrey,
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenUtil().setSp(16)),
                          ),
                          SizedBox(
                              height: ScreenUtil().setHeight(20)),
                          Wrap(
                            spacing: 10.0,
                            runSpacing: 6.0,
                            children: List<Widget>.generate(
                                providerData.insurancePlans.length,
                                    (int index) {
                                  bool checkContain = _filters2.contains(
                                      providerData
                                          .insurancePlans[index].id);
                                  return InputChip(
                                    showCheckmark: false,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      side: BorderSide(
                                        color: checkContain
                                            ? ColorsUtils.blueColor
                                            : ColorsUtils
                                            .onBoardingTextGrey,
                                      ),
                                    ),
                                    label: Text(providerData
                                        .insurancePlans[index].name),
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
                                    backgroundColor:
                                    ColorsUtils.greyColor,
                                    selectedColor: ColorsUtils.blueColor,
                                    selected: checkContain,
                                    selectedShadowColor: null,
                                    onDeleted: () {},
                                    onSelected: (val) {
                                      setState(() {
                                        if (val) {
                                          _filters2.add(providerData
                                              .insurancePlans[index].id);
                                          ownedClinic
                                              .existingInsurancePlans =
                                              _filters2;
                                        } else {
                                          _filters2.removeWhere((int id) {
                                            return id ==
                                                providerData
                                                    .insurancePlans[index]
                                                    .id;
                                          });
                                          ownedClinic
                                              .existingInsurancePlans =
                                              _filters2;
                                        }
                                        print(ownedClinic
                                            .existingInsurancePlans
                                            .toString());
                                      });
                                    },
                                  );
                                }),
                          ),
                          SizedBox(
                              height: ScreenUtil().setHeight(10)),
                          Container(
                            height: ScreenUtil().setHeight(35),
                            width: ScreenUtil().setWidth(170.0),
                            child: InputChip(
                              padding: EdgeInsets.zero,
                              showCheckmark: false,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(8.0),
                                side: BorderSide(
                                  color:
                                  ColorsUtils.onBoardingTextGrey,
                                ),
                              ),
                              avatar: false
                                  ? null
                                  : Icon(
                                Icons.add,
                                color: ColorsUtils.blueColor,
                              ),
                              label: TextFormField(
                                controller: _addOtherPlanController,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(bottom: 12.0),
                                  hintText: 'Add Other Plan',
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusedErrorBorder:
                                  InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                onChanged: (val) {
                                  ownedClinic.newInsurancePlans = [];
                                },
                                onSaved: (val) {
                                  print(val);
                                  ownedClinic.newInsurancePlans = [];
                                },
                              ),
                              labelStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w600,
                                color: false
                                    ? Colors.white
                                    : ColorsUtils.textGrey,
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
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: ScreenUtil().setHeight(50),
                              width: 236,
                              child: CustomRoundedButton(
                                backgroundColor:
                                ColorsUtils.primaryGreen,
                                borderColor: ColorsUtils.primaryGreen,
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                                text: 'Continue',
                                pressed: () {
                                  if (_formKey.currentState
                                      .validate()) {
                                    _formKey.currentState.save();
                                    CustomFunctions.popScreen(context);
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
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
