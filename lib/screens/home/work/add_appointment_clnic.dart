import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';


class AddAppointmentPage extends StatefulWidget {

  final int id;
  AddAppointmentPage(this.id);
  @override
  _AddAppointmentPageState createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> days = ['sat', 'sun', 'mon', 'tue', 'wed', 'thu', 'fri'];
  List<String> _filters=[];
  Map<String,dynamic> _appointmentInfo={};
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final clinicProvider = Provider.of<ClinicsProvider>(context, listen: false);
    return Scaffold(
      body: Builder(
        builder: (context)=> SingleChildScrollView(
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
                                onSaved: (val) {
                                  _appointmentInfo['from']=val;
                                },
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
                                onSaved: (val) {
                                  _appointmentInfo['to']=val;
                                },
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
                      onSaved: (val) {
                        _appointmentInfo['time_slot']=int.tryParse(val);
                      },
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
                    loading?Center(child: CircularProgressIndicator()):    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        height: ScreenUtil().setHeight(50),
                        child: CustomRoundedButton(
                          backgroundColor: ColorsUtils.primaryGreen,
                          borderColor: ColorsUtils.primaryGreen,
                          text: 'Add',
                          pressed: () async{
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              if(_filters.isNotEmpty){
                                _appointmentInfo['days']=_filters;
                                print(_appointmentInfo.toString());
                                setState(() {
                                  loading = true;
                                });

                                try {
                                final responseStatus=  await clinicProvider.addAppointment(
                                      widget.id, _appointmentInfo);
                                  if (responseStatus == 201) {
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
                                    text: 'The Time of Appointment is Reserved!',
                                    hasIcon: true,
                                    iconType: Icons.error_outline,
                                    iconColor: Colors.red,
                                  );
                                }




                              }else{
                                print('u should enter at least day');
                              }

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
        ),
      ),
    );
  }
}
