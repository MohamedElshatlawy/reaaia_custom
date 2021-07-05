import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

class AddAppointmentPage extends StatefulWidget {
  @override
  _AddAppointmentPageState createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> days = ['sat', 'sun', 'mon', 'tue', 'wen', 'thu', 'fri'];
  List<String> _filters=[];

  @override
  Widget build(BuildContext context) {
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
                  'New Appointment',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(17),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From',
                            style: TextStyle(
                                color: ColorsUtils.onBoardingTextGrey,
                                fontSize: ScreenUtil().setSp(13),
                                fontWeight: FontWeight.bold),
                          ),
                          CustomTextField(
                            icon: Icon(
                              Icons.access_time,
                              color: ColorsUtils.blueColor,
                            ),
                            filledColor: Colors.white,
                            hintText: '08:00 AM or PM',
                            hintStyle: TextStyle(fontSize: 12.0),
                            hasBorder: true,
                            onSaved: (val) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This Field Required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'To',
                            style: TextStyle(
                                color: ColorsUtils.onBoardingTextGrey,
                                fontSize: ScreenUtil().setSp(13),
                                fontWeight: FontWeight.bold),
                          ),
                          CustomTextField(
                            icon: Icon(
                              Icons.access_time,
                              color: ColorsUtils.blueColor,
                            ),
                            filledColor: Colors.white,
                            hintText: '09:00 AM or PM',
                            hintStyle: TextStyle(fontSize: 12.0),
                            hasBorder: true,
                            onSaved: (val) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This Field Required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: ' Time Slot ( Min.)',
                  hasBorder: true,
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This Field Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                Text(
                  'Working Day',
                  style: TextStyle(
                      color: ColorsUtils.onBoardingTextGrey,
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: ScreenUtil().setHeight(15)),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 6.0,
                  children: List<Widget>.generate(
                    days.length,
                    (int index) {
                      bool checkContain =
                      _filters.contains(days[index]);
                      return FilterChip(
                        showCheckmark: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: checkContain
                                ? ColorsUtils.blueColor
                                : ColorsUtils.onBoardingTextGrey,
                          ),
                        ),
                        label: Text(days[index].toUpperCase()),
                        labelStyle: TextStyle(
                          fontSize: ScreenUtil().setSp(13),
                          fontWeight: FontWeight.w600,
                          color: checkContain
                              ? Colors.white
                              : ColorsUtils.onBoardingTextGrey,
                        ),

                        backgroundColor: Colors.white,
                        selectedColor: ColorsUtils.blueColor,
                        selected: checkContain,
                        selectedShadowColor: null,

                        onSelected: (val) {
                          setState(() {
                            if (val) {
                              _filters.add(days[index]);
                            } else {
                              _filters.removeWhere((String name) {
                                return name == days[index];
                              });

                            }
                            print(_filters.toString());
                          });
                        },
                      );

                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(color: ColorsUtils.lineColor,),
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    height: ScreenUtil().setHeight(50),
                    child: CustomRoundedButton(
                      backgroundColor: ColorsUtils.primaryGreen,
                      borderColor: ColorsUtils.primaryGreen,
                      text: 'Add',
                      pressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          CustomFunctions.popScreen(context);
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
