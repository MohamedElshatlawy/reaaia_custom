import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/data/signupModels/address_model.dart';
import 'package:reaaia/model/data/signup/complete_reg1_model.dart';
import 'package:reaaia/screens/auth/signup/complete_req1_map.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/home/profile/choose_gender.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/sign_up_provider.dart';
import 'package:validators/validators.dart';

class EditProfilePage extends StatefulWidget {
  //final int userId;

  //CompleteRegister1({@required this.userId});
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _mapController = TextEditingController();
  bool isMale = false;
  bool isFemale = false;
  File image;
  DateTime pickedDataStartFrom;
  LatLng _latLng;
  CompleteReg1Model _completeReg1Model = CompleteReg1Model();

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtil().setHeight(35)),
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
                        'Edit Profile',
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
                  SizedBox(height: ScreenUtil().setHeight(14)),
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                              width: ScreenUtil().setWidth(89),
                              height: ScreenUtil().setHeight(89),
                              //padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]),
                                  borderRadius: BorderRadius.circular(17)),
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
                                    _completeReg1Model.avatarImage.clear();
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
                                        border:
                                            Border.all(color: Colors.grey[300]),
                                        borderRadius: BorderRadius.circular(8)),
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
                                      await Provider.of<SignUpProvider>(context,
                                              listen: false)
                                          .uploadPicture(
                                              collection: 'Doctor avatar image',
                                              file: image);
                                      if (signUpProvider.tokenPicture != null) {
                                        _completeReg1Model.avatarImage = [
                                          signUpProvider.tokenPicture
                                        ];
                                        print(
                                            'we found token ${signUpProvider.tokenPicture}');
                                        Functions.showCustomSnackBar(
                                          context: context,
                                          text: 'Picture Upload Successfully',
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
                              SizedBox(height: ScreenUtil().setHeight(5)),
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
                  SizedBox(height: ScreenUtil().setHeight(25)),
                  CustomTextField(
                    initialValue: 'MOhamed Gwaan',
                    filledColor: Colors.white,
                    lablel: ' Full Name',
                    hasBorder: true,
                    onSaved: (val) {
                      _completeReg1Model.name = val;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  CustomTextField(
                    initialValue: '@MOhamedGwaan',
                    filledColor: Colors.white,
                    lablel: ' UserName/Url*',
                    isEmail: true,
                    hasBorder: true,
                    onSaved: (val) {
                      _completeReg1Model.email = val;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field Required';
                      } else if (!isEmail(value)) {
                        return 'enter Valid Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(5)),
                  Text(
                    '  Your public username is the same as your url',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: ColorsUtils.onBoardingTextGrey),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Row(
                    children: [
                      ChooseGender(
                        iconName: 'assets/icons/ic_male.svg',
                        backgroundColor:
                            isMale ? ColorsUtils.blueColor : Colors.white,
                        iconColor: isMale
                            ? Colors.white
                            : ColorsUtils.onBoardingTextGrey,
                        textColor: isMale
                            ? Colors.black
                            : ColorsUtils.onBoardingTextGrey,
                        genderName: 'MALE',
                        onTap: () {
                          setState(() {
                            isMale = true;
                            isFemale = false;
                            _completeReg1Model.gender = 'male';
                          });
                        },
                      ),
                      SizedBox(width: ScreenUtil().setWidth(15)),
                      ChooseGender(
                        iconName: 'assets/icons/ic_female.svg',
                        backgroundColor:
                            isFemale ? ColorsUtils.blueColor : Colors.white,
                        iconColor: isFemale
                            ? Colors.white
                            : ColorsUtils.onBoardingTextGrey,
                        textColor: isFemale
                            ? Colors.black
                            : ColorsUtils.onBoardingTextGrey,
                        genderName: 'FEMALE',
                        onTap: () {
                          setState(() {
                            isMale = false;
                            isFemale = true;
                            _completeReg1Model.gender = 'female';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(30)),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2019, 1),
                        lastDate: DateTime(2021, 12),
                      ).then((pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            _controller.text = DateFormat(" d MMM y")
                                .format(pickedDate)
                                .toString();
                            pickedDataStartFrom = pickedDate;
                            _completeReg1Model.dateOfBirth =
                                pickedDate.toIso8601String();
                          });
                        }
                      });
                    },
                    child: IgnorePointer(
                      child: CustomTextField(
                        controller: _controller,
                        readOnly: true,
                        filledColor: Colors.white,
                        lablel: ' Date of Birthday*',
                        hasBorder: true,
                        sufficIcon: Icon(
                          Icons.date_range,
                          color: ColorsUtils.blueColor,
                        ),
                        onSaved: (val) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This Field Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  InkWell(
                    onTap: () {
                      // CustomFunctions.pushScreen(context: context,widget: CompleteRequest1Map());

                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => CompleteRequest1Map()))
                          .then((value) {
                        setState(() {
                          _latLng = value as LatLng;
                          print(value.toString());
                          _mapController.text = 'Lat:' +
                              _latLng.latitude.toStringAsFixed(2) +
                              ' Lng:' +
                              _latLng.longitude.toStringAsFixed(2);

                          /// add to Model
                          _completeReg1Model.address = Address(
                            detailedAddress: '24 Abbas Akkad Street',
                            latitude: _latLng.latitude,
                            longitude: _latLng.longitude,
                          );
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
                          if (value == null || value.isEmpty) {
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
                          color: ColorsUtils.onBoardingTextGrey,
                        ),
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
                        text: 'Save',
                        pressed: () {
                          // if (_formKey.currentState.validate()) {
                          //   _formKey.currentState.save();
                          //   FocusManager.instance.primaryFocus.unfocus();
                          //   if(image!=null && _completeReg1Model.gender!=null){
                          //     _completeReg1Model.doctorUserId=widget.userId;
                          //     Provider.of<SignUpProvider>(context,listen: false).setCompleteReg1Model(_completeReg1Model);
                          //     CustomFunctions.pushScreen(
                          //         context: context, widget: CompleteRegister2());
                          //   }else{
                          //
                          //     Functions.showCustomSnackBar(
                          //       context: context,
                          //       text: 'Some Fields Required- Image Or Gender!',
                          //       hasIcon: false,
                          //     );
                          //   }
                          //
                          // }
                        },
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
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


