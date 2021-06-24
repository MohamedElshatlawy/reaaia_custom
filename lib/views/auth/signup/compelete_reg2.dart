import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/views/auth/signup/compelete_reg3.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

class CompleteRegister2 extends StatefulWidget {
  @override
  _CompleteRegister2State createState() => _CompleteRegister2State();
}

class _CompleteRegister2State extends State<CompleteRegister2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _addSubSpecialityController = TextEditingController();

  var items = [
    'Consultant',
    'Specialist',
    'General Practitioner (GP)',
  ];

  var languages = [
    'اللغة العربية',
    'English',
  ];
  var levelLanguages = [
    'Native',
    'Level 1',
    'Level 2',
  ];

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

  String selectedScientificDegree;
  String selectedLanguage;
  String selectedLevelLanguage;

  bool isSelectedScientificDegree = false;
  bool isSelectedSpeciality = false;
  bool isSelectedSubSpeciality = false;


  Future<File> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final String fileName = pickedFile.path.split('/').last;

      final imageFile = await MultipartFile.fromPath('file',pickedFile.path,
          filename: fileName,
          contentType: MediaType('image', fileName.split('.').last));

      return File(pickedFile.path);
      // setState(() {
      //   _editAccountInfo['image'] = imageFile;
      //   image = File(pickedFile.path);
      // });
    } else {
     return null;
    }

  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder borderScientificDegree = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: isSelectedScientificDegree
                ? ColorsUtils.onBoardingTextGrey
                : ColorsUtils.borderColor));

    OutlineInputBorder borderSpeciality = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: isSelectedScientificDegree
                ? ColorsUtils.onBoardingTextGrey
                : ColorsUtils.borderColor));

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
                      'Education',
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
                        'Update your profile to get better engagment.',
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
                  decoration: InputDecoration(
                    labelText: 'Scientific Degree*',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(15)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return new DropdownMenuItem(
                      child: new Text(value),
                      value: value,
                    );
                  }).toList(),
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
                                        'Select Speciality',
                                        style: TextStyle(
                                            color:
                                                ColorsUtils.onBoardingTextGrey,
                                            fontSize: ScreenUtil().setSp(16)),
                                      ),
                                      Text(
                                        'you can select only one Speciality',
                                        style: TextStyle(
                                            color:
                                                ColorsUtils.onBoardingTextGrey,
                                            fontSize: ScreenUtil().setSp(13)),
                                      ),
                                      SizedBox(
                                          height: ScreenUtil().setHeight(20)),
                                      Flexible(
                                        child: ListView.builder(
                                            itemCount: listOfSpeciality.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    _controller.text =
                                                        listOfSpeciality[index];
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
                                                  listOfSpeciality[index],
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
                      }),
                ),
                SizedBox(height: ScreenUtil().setHeight(15)),
                Divider(
                  color: ColorsUtils.lineColor,
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),

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
                  children:
                      List<Widget>.generate(_dynamicChips.length, (int index) {
                    bool checkContain = _filters.contains(_dynamicChips[index]);
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
                        color:
                            checkContain ? Colors.white : ColorsUtils.textGrey,
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
                    label:  TextFormField(
                      controller: _addSubSpecialityController,
                        textInputAction: TextInputAction.done,
                      onFieldSubmitted: (val){
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
                    onDeleted:true?null: () {},
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
                /// //////////////////////////
                SizedBox(height: ScreenUtil().setHeight(20)),
                InkWell(
                  onTap: ()async{
                    final pickedImage= await pickImage();
                    if(pickedImage!=null){
                      print('upload Succes');
                    }else{
                      print('upload Falid');
                    }
                  },
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().setHeight(68),
                    //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
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
                        Text(
                          'Upload Latest \nProfessional Practice licence',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(12),
                              color: ColorsUtils.textGrey),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: ' Graduation University',
                  hasBorder: true,
                  onSaved: (val) {},
                  errorMessage: 'Enter Graduation University!',
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Divider(
                  color: ColorsUtils.lineColor,
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),

                /// language
                Container(
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().setHeight(250),
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Language',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(16),
                            color: ColorsUtils.primaryGreen),
                      ),
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
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        isExpanded: true,
                        value: selectedLanguage,
                        iconSize: 24,
                        onChanged: (newValue) {
                          setState(() {
                            selectedLanguage = newValue;
                          });
                        },
                        items: languages
                            .map<DropdownMenuItem<String>>((String value) {
                          return new DropdownMenuItem(
                            child: new Text(value),
                            value: value,
                          );
                        }).toList(),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Level of Language',
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
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        isExpanded: true,
                        value: selectedLevelLanguage,
                        iconSize: 24,
                        onChanged: (newValue) {
                          setState(() {
                            selectedLevelLanguage = newValue;
                          });
                        },
                        items: levelLanguages
                            .map<DropdownMenuItem<String>>((String value) {
                          return new DropdownMenuItem(
                            child: new Text(value),
                            value: value,
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
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
                          text: 'Add More Language ',
                          pressed: () {

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
                        'Certification',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(16),
                            color: ColorsUtils.primaryGreen),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(16)),
                      CustomTextField(
                        filledColor: Colors.white,
                        lablel: ' Certificate Name',
                        hasBorder: true,
                        onSaved: (val) {},
                        errorMessage: 'Enter Certificate Name!',
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      CustomTextField(
                        filledColor: Colors.white,
                        lablel: ' Year',
                        hasBorder: true,
                        onSaved: (val) {},
                        errorMessage: 'Enter Year!',
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      InkWell(
                        onTap: ()async{
                          final pickedImage= await pickImage();
                          if(pickedImage!=null){
                            print('upload Succes');
                          }else{
                            print('upload Falid');
                          }
                        },
                        child: Container(
                          width: ScreenUtil().screenWidth,
                          height: ScreenUtil().setHeight(50),
                          //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
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
                              Text(
                                'Attach Certificate Photo',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenUtil().setSp(13),
                                    color: ColorsUtils.textGrey),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
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
                          text: 'Add More Certificate ',
                          pressed: () {

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
                        'Awards',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(16),
                            color: ColorsUtils.primaryGreen),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(16)),
                      CustomTextField(
                        filledColor: Colors.white,
                        lablel: ' Award Name ',
                        hasBorder: true,
                        onSaved: (val) {},
                        errorMessage: 'Enter Award Name!',
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      CustomTextField(
                        filledColor: Colors.white,
                        lablel: ' Year',
                        hasBorder: true,
                        onSaved: (val) {},
                        errorMessage: 'Enter Year!',
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      InkWell(
                        onTap: ()async{
                          final pickedImage= await pickImage();
                          if(pickedImage!=null){
                            print('upload Succes');
                          }else{
                            print('upload Falid');
                          }
                        },
                        child: Container(
                          width: ScreenUtil().screenWidth,
                          height: ScreenUtil().setHeight(50),
                          //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
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
                              Text(
                                'Attach Award Photo',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenUtil().setSp(13),
                                    color: ColorsUtils.textGrey),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
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
                          text: 'Add More Award ',
                          pressed: () {

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
                      icon: Icon(Icons.arrow_forward,color: Colors.white,),
                      text: 'Continue',
                      pressed: () {
                        CustomFunctions.pushScreen(
                            context: context, widget: CompleteRegister3());
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
    );
  }
}
