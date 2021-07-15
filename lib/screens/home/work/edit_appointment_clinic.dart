import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/model/clinics/branchModels/appointments_model.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';

class EditAppointmentPage extends StatefulWidget {
  final int id;
  final AppointmentsData appointmentData;
  EditAppointmentPage(this.id, this.appointmentData);
  @override
  _EditAppointmentPageState createState() => _EditAppointmentPageState();
}

class _EditAppointmentPageState extends State<EditAppointmentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _editAppointmentInfo = {};
  List<Map<String, dynamic>> appointments=[];
  List<int> deletedAppointments=[];

  bool loading = false;

  @override
  void initState() {
    super.initState();
    widget.appointmentData.appointments.map((e) => appointments.add({})).toList();
    print(appointments.length);
  }

  @override
  Widget build(BuildContext context) {
    final clinicProvider = Provider.of<ClinicsProvider>(context, listen: false);
    return SingleChildScrollView(

        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 520,
                width: ScreenUtil().screenWidth,
                padding: EdgeInsets.only(top: 35.0, left: 25.0,right: 25.0),
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
                      widget.appointmentData.day,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(17),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        //height:widget.appointmentData.appointments.length!=1? 335.0:170.0,
                        //height: 335,
                        width: ScreenUtil().screenWidth,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.appointmentData.appointments.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'From',
                                                  style: TextStyle(
                                                      color: ColorsUtils
                                                          .onBoardingTextGrey,
                                                      fontSize:
                                                          ScreenUtil().setSp(13),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                CustomTextField(
                                                  key: Key(widget.appointmentData.appointments[index].from),
                                                  initialValue: widget.appointmentData.appointments[index].from,
                                                  icon: Icon(
                                                    Icons.access_time,
                                                    color: ColorsUtils.blueColor,
                                                  ),
                                                  filledColor: Colors.white,
                                                  hintText: '08:00 AM or PM',
                                                  hintStyle:
                                                      TextStyle(fontSize: 12.0),
                                                  hasBorder: true,
                                                  onSaved: (String val) {
                                                    appointments[index]['id'] = widget.appointmentData.appointments[index].id;
                                                    appointments[index]['from'] = val.substring(0,5);
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
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
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'To',
                                                  style: TextStyle(
                                                      color: ColorsUtils
                                                          .onBoardingTextGrey,
                                                      fontSize:
                                                          ScreenUtil().setSp(13),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                CustomTextField(
                                                  key: Key(widget.appointmentData.appointments[index].to),
                                                  initialValue: widget.appointmentData.appointments[index].to,
                                                  icon: Icon(
                                                    Icons.access_time,
                                                    color: ColorsUtils.blueColor,
                                                  ),
                                                  filledColor: Colors.white,
                                                  hintText: '09:00 AM or PM',
                                                  hintStyle:
                                                      TextStyle(fontSize: 12.0),
                                                  hasBorder: true,
                                                  onSaved: (String val) {
                                                    appointments[index]['to'] = val.substring(0,5);
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
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
                                        key: Key(widget.appointmentData.appointments[index].timeSlot.toString()),
                                        initialValue: widget.appointmentData.appointments[index].timeSlot.toString(),
                                        filledColor: Colors.white,
                                        lablel: ' Time Slot ( Min.)',
                                        hasBorder: true,
                                        onSaved: (val) {
                                          appointments[index]['time_slot']  = int.tryParse(val);
                                          //_appointmentInfo['time_Slot']=val;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'This Field Required';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: ScreenUtil().setHeight(10)),
                                      if(index != (widget.appointmentData.appointments.length-1))
                                      Divider(
                                        color: ColorsUtils.onBoardingTextGrey.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                  width: ScreenUtil().screenWidth*0.75,
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                InkWell(
                                  onTap: () {

                                    deletedAppointments.add(widget.appointmentData.appointments[index].id);
                                    setState(() {
                                      widget.appointmentData.appointments.removeAt(index);
                                      appointments.removeAt(index);
                                    });

                                    print(deletedAppointments.toString());
                                    print(jsonEncode(widget.appointmentData.appointments).toString());

                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(top: 35.0),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.grey[300]),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                        size: 15.0,
                                      ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Divider(
                        color: ColorsUtils.lineColor,
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    loading
                        ? Center(child: CircularProgressIndicator())
                        : Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              height: ScreenUtil().setHeight(50),
                              child: CustomRoundedButton(
                                backgroundColor: ColorsUtils.primaryGreen,
                                borderColor: ColorsUtils.primaryGreen,
                                text: 'Save',
                                pressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    print(appointments.toString());

                                    _editAppointmentInfo['deleted_appointments']=deletedAppointments;
                                    _editAppointmentInfo['updated_appointments']=appointments;
                                     print(_editAppointmentInfo.toString());
                                    setState(() {
                                      loading = true;
                                    });

                                    try {
                                      final responseStatus =
                                          await clinicProvider.editAppointment(
                                              widget.id, _editAppointmentInfo);
                                      if (responseStatus == 200) {
                                        setState(() {
                                          loading = false;
                                        });
                                        Navigator.pop(context);
                                        // CustomFunctions.popScreen(context);
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
                                      setState(() {
                                        loading = false;
                                      });
                                      Functions.showCustomSnackBar(
                                        context: context,
                                        text:
                                            'The Time of Appointment is Reserved!',
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

                    SizedBox(height: ScreenUtil().setHeight(20)),
                  ],
                ),
              ),
            ),
          ),
        ),

    );
  }
}
