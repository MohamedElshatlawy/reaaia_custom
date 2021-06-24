import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/sign_up_provider.dart';
import 'package:reaaia/views/auth/signup/add_serve.dart';
import 'package:reaaia/views/auth/signup/complete_req1_map.dart';
import 'package:reaaia/views/auth/signup/congrats.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

import '../../customFunctions.dart';

class CompleteRegister3 extends StatefulWidget {
  @override
  _CompleteRegister3State createState() => _CompleteRegister3State();
}

class _CompleteRegister3State extends State<CompleteRegister3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _addSubSpecialityController = TextEditingController();
  TextEditingController _addOtherPlanController = TextEditingController();

  String selectedCity;
  String selectedCityArea;

  bool _isOwn = true;
  bool isSelectedSpeciality = false;
  bool isSelectedSubSpeciality = false;
  String hospitalName;

  String jobTitle;

  String startForm;
  DateTime pickedDataStartFrom;

  var listOfSpeciality = [
    'Allergy & Immunology',
    'Anesthesiology',
    'Cardiology',
    'Deficiency',
    'Dermatology',
    'Disability',
    'Emergency',
    'Endocrinology',
  ];
  List<String> _dynamicChips = [
    'Health',
    'Adult Internal Medicine',
    'Adult Allergy / Immunology',
    'Pediatric Allergy / Immunology',
    'Adult Chest / Respiratory',
  ];
  List<String> _filters = [];
  var cities = [
    'Cairo',
    'Alex',
    'Giza',
    'Qena',
  ];

  var areas = [
    'eltgamo3',
    'elmaadi',
    'smoha',
    'agmi',
  ];
  List<String> _dynamicChips2 = [
    'AXA',
    'Cigan',
    'Test1',
    'Test2',
  ];
  List<String> _filters2 = [];

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorsUtils.borderColor));

    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
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
                    InkWell(
                      onTap: () {
                        //CustomFunctions.pushScreen(context: context, widget: Login());
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: ColorsUtils.onBoardingTextGrey,
                            fontSize: ScreenUtil().setSp(17),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Row(
                  children: [
                    Text(
                      'Healthcare',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(24)),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(17)),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Select you Healthcare Type',
                        style: TextStyle(
                            color: ColorsUtils.onBoardingTextGrey,
                            fontSize: ScreenUtil().setSp(13)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
                  height: ScreenUtil().setHeight(50),
                  decoration: BoxDecoration(
                      color: ColorsUtils.containerHealthCareColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomRoundedButton(
                          backgroundColor: _isOwn
                              ? ColorsUtils.primaryGreen
                              : ColorsUtils.containerHealthCareColor,
                          borderColor: _isOwn
                              ? ColorsUtils.primaryGreen
                              : ColorsUtils.containerHealthCareColor,
                          textColor: _isOwn
                              ? Colors.white
                              : ColorsUtils.onBoardingTextGrey,
                          text: 'I Own',
                          pressed: () {
                            setState(() {
                              _isOwn = true;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(10),
                      ),
                      Expanded(
                        child: CustomRoundedButton(
                          backgroundColor: _isOwn
                              ? ColorsUtils.containerHealthCareColor
                              : ColorsUtils.primaryGreen,
                          borderColor: _isOwn
                              ? ColorsUtils.containerHealthCareColor
                              : ColorsUtils.primaryGreen,
                          textColor: _isOwn
                              ? ColorsUtils.onBoardingTextGrey
                              : Colors.white,
                          text: 'I Serve',
                          pressed: () {
                            setState(() {
                              _isOwn = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(25)),
                if (_isOwn)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Scientific Degree
                      CustomTextField(
                        filledColor: Colors.white,
                        lablel: ' Hospital / Clinic Name',
                        hasBorder: true,
                        onSaved: (val) {},
                        errorMessage: 'Enter Hospital / Clinic Name!',
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      CustomTextField(
                        controller: _controller,
                        readOnly: true,
                        filledColor: isSelectedSpeciality ? null : Colors.white,
                        lablel: ' Select Specialty*',
                        style: TextStyle(
                            color: ColorsUtils.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(16)),
                        hasBorder: true,
                        onSaved: (val) {},
                        errorMessage: 'choose Specialty!',
                        sufficIcon: IconButton(
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                            onPressed: () {
                              showModalBottomSheet(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(24),
                                    topLeft: Radius.circular(24),
                                  )),
                                  barrierColor:
                                      ColorsUtils.modalSheetBarrierColor,
                                  backgroundColor:
                                      ColorsUtils.modalSheetBarrierColor,
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
                                              'Select Speciality',
                                              style: TextStyle(
                                                  color: ColorsUtils
                                                      .onBoardingTextGrey,
                                                  fontSize:
                                                      ScreenUtil().setSp(16)),
                                            ),
                                            Text(
                                              'you can select only one Speciality',
                                              style: TextStyle(
                                                  color: ColorsUtils
                                                      .onBoardingTextGrey,
                                                  fontSize:
                                                      ScreenUtil().setSp(13)),
                                            ),
                                            SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(20)),
                                            Flexible(
                                              child: ListView.builder(
                                                  itemCount:
                                                      listOfSpeciality.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      onTap: () {
                                                        setState(() {
                                                          _controller.text =
                                                              listOfSpeciality[
                                                                  index];
                                                          isSelectedSpeciality =
                                                              true;
                                                        });

                                                        Navigator.pop(context);
                                                      },
                                                      leading: Container(
                                                          height: ScreenUtil()
                                                              .setHeight(40),
                                                          width: ScreenUtil()
                                                              .setWidth(40),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  7.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ColorsUtils
                                                                .primaryGreen,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          child: SvgPicture.asset(
                                                              'assets/icons/ic_allergiesonly.svg')),
                                                      title: Text(
                                                        listOfSpeciality[index],
                                                        style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(15),
                                                          fontWeight:
                                                              FontWeight.w600,
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
                            }),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(15)),
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
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 6.0,
                        children: List<Widget>.generate(_dynamicChips.length,
                            (int index) {
                          bool checkContain =
                              _filters.contains(_dynamicChips[index]);
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
                            label: Text(_dynamicChips[index]),
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
                                  _filters.add(_dynamicChips[index]);
                                } else {
                                  _filters.removeWhere((String name) {
                                    return name == _dynamicChips[index];
                                  });
                                }
                                print(_filters.toString());
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
                                _dynamicChips.add(val);
                                _addSubSpecialityController.clear();
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 12.0),
                              hintText: 'Add Other Specialty',
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onSaved: (val) {},
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
                          onSelected: (val) {
                            setState(() {
                              if (val) {
                                _filters.add('hi');
                              } else {
                                _filters.removeWhere((String name) {
                                  return name == 'hi';
                                });
                              }
                              print(_filters.toString());
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      Divider(
                        color: ColorsUtils.lineColor,
                      ),

                      /// address and city
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'City',
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
                              value: selectedCity,
                              iconSize: 24,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCity = newValue;
                                });
                              },
                              items: cities.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return new DropdownMenuItem(
                                  child: new Text(value),
                                  value: value,
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(25.0),
                          ),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Area',
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
                              value: selectedCityArea,
                              iconSize: 24,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCityArea = newValue;
                                });
                              },
                              items: areas.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return new DropdownMenuItem(
                                  child: new Text(value),
                                  value: value,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      CustomTextField(
                        filledColor: Colors.white,
                        lablel: ' Main Address*',
                        hasBorder: true,
                        errorMessage: 'Enter Address!',
                        icon: Icon(
                          Icons.location_on_outlined,
                          color: ColorsUtils.blueColor,
                        ),
                        sufficIcon: IconButton(icon: Icon(Icons.my_location,color: ColorsUtils.onBoardingTextGrey,),onPressed: (){
                          CustomFunctions.pushScreen(context: context,widget: CompleteRequest1Map());
                        },),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Divider(
                        color: ColorsUtils.lineColor,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),

                      /// phone number

                      CustomTextField(
                        filledColor: Colors.white,
                        lablel: ' Phone Number*',
                        hasBorder: true,
                        errorMessage: 'Enter Phone Number!',
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Container(
                        height: ScreenUtil().setHeight(40),
                        child: CustomRoundedButton(
                          iconLeft: true,
                          backgroundColor: ColorsUtils.buttonColorLight,
                          borderColor: ColorsUtils.buttonColorLight,
                          icon: Icon(
                            Icons.add,
                            color: ColorsUtils.primaryGreen,
                          ),
                          text: 'Add More Language ',
                          pressed: () {},
                          textColor: ColorsUtils.primaryGreen,
                        ),
                      ),

                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Divider(
                        color: ColorsUtils.lineColor,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),

                      /// Accepted Insurance Plans
                      Text(
                        'Accepted Insurance Plans',
                        style: TextStyle(
                            color: ColorsUtils.textGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: ScreenUtil().setSp(16)),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 6.0,
                        children: List<Widget>.generate(_dynamicChips2.length,
                            (int index) {
                          bool checkContain =
                              _filters2.contains(_dynamicChips2[index]);
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
                            label: Text(_dynamicChips2[index]),
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
                                  _filters2.add(_dynamicChips2[index]);
                                } else {
                                  _filters2.removeWhere((String name) {
                                    return name == _dynamicChips2[index];
                                  });
                                }
                                print(_filters2.toString());
                              });
                            },
                          );
                        }),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Container(
                        height: ScreenUtil().setHeight(35),
                        width: ScreenUtil().setWidth(170.0),
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
                            controller: _addOtherPlanController,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (val) {
                              setState(() {
                                _dynamicChips2.add(val);
                                _addOtherPlanController.clear();
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 12.0),
                              hintText: 'Add Other Plan',
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onSaved: (val) {},
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
                          onSelected: (val) {
                            // setState(() {
                            //   if (val) {
                            //     _filters2.add('hi');
                            //   } else {
                            //     _filters2.removeWhere((String name) {
                            //       return name == 'hi';
                            //     });
                            //   }
                            //   print(_filters2.toString());
                            // });
                          },
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
                            backgroundColor: ColorsUtils.primaryGreen,
                            borderColor: ColorsUtils.primaryGreen,
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            text: 'Continue',
                            pressed: () {
                              setState(() {
                                _isOwn = false;
                              });
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
                else
                  Column(
                    children: [
                      Consumer<SignUpProvider>(
                        builder: (context, provider, child) {
                          return provider.serves.length == 0
                              ? Column(
                                  children: [
                                    SizedBox(height: ScreenUtil().setHeight(20)),
                                    CustomTextField(
                                      filledColor: Colors.white,
                                      lablel: ' Hospital / Clinic Name',
                                      hasBorder: true,
                                      errorMessage: 'Enter Hospital / Clinic Name!',
                                      onSaved: (val){
                                        hospitalName=val;
                                      },
                                    ),
                                    SizedBox(height: ScreenUtil().setHeight(20)),
                                    CustomTextField(
                                        readOnly: true,
                                        controller: _controller,
                                        filledColor: Colors.white,
                                        lablel: ' Started from',
                                        hasBorder: true,
                                        errorMessage: 'Enter Date!',
                                        onSaved: (val){
                                          startForm=val;
                                        },
                                        sufficIcon: IconButton(
                                          icon: Icon(
                                            Icons.date_range,
                                            color: ColorsUtils.blueColor,
                                          ),
                                          onPressed: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2019, 1),
                                              lastDate: DateTime(2021, 12),
                                            ).then((pickedDate) {
                                              if(pickedDate!=null) {
                                                setState(() {
                                                  _controller.text = DateFormat(" d MMM y")
                                                      .format(pickedDate)
                                                      .toString();
                                                  pickedDataStartFrom=pickedDate;

                                                });
                                              }
                                            });
                                          },
                                        )),
                                    SizedBox(height: ScreenUtil().setHeight(20)),
                                    CustomTextField(
                                      filledColor: Colors.white,
                                      lablel: ' Job Title',
                                      hasBorder: true,
                                      errorMessage: 'Enter Job Title!',
                                      onSaved: (val){
                                        jobTitle=val;
                                      },
                                    ),
                                    SizedBox(height: ScreenUtil().setHeight(20)),
                                  ],
                                )
                              : ListView.builder(
                            physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: provider.serves.length,
                                itemBuilder: (context, index) {
                                  final serve = provider.serves[index];
                                  return Card(
                                    margin: EdgeInsets.only(bottom: 15.0),
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 25.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            serve.jobTitle +
                                                ' at ' +
                                                serve.hospitalName,
                                            style: TextStyle(
                                                color:
                                                    ColorsUtils.blueColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    ScreenUtil().setSp(15)),
                                          ),
                                          Text(
                                              DateFormat(" d MMM y")
                                                  .format(serve.startedFrom)
                                                  .toString(),
                                            style: TextStyle(
                                                color: ColorsUtils
                                                    .onBoardingTextGrey,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    ScreenUtil().setSp(13)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(40),
                        child: CustomRoundedButton(
                          iconLeft: true,
                          backgroundColor: ColorsUtils.buttonColorLight,
                          borderColor: ColorsUtils.buttonColorLight,
                          icon: Icon(
                            Icons.add,
                            color: ColorsUtils.primaryGreen,
                          ),
                          text: 'Add Another Place',
                          pressed: () {
                            showModalBottomSheet(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24),
                                topLeft: Radius.circular(24),
                              )),
                              barrierColor: ColorsUtils.modalSheetBarrierColor,
                              backgroundColor:
                                  ColorsUtils.modalSheetBarrierColor,
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return AddServe();
                              },
                            );
                          },
                          textColor: ColorsUtils.primaryGreen,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
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
                            text: 'Send Verify Request',
                            pressed: () {
                             CustomFunctions.pushScreen(context: context,widget: Congrats());
                            },
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
