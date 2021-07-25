import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/model/data/signup/serving_health_care_model.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';


class AddServeClinic extends StatefulWidget {
  @override
  _AddServeClinicState createState() => _AddServeClinicState();
}

class _AddServeClinicState extends State<AddServeClinic> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  String hospitalName;

  String jobTitle;

  String startForm;
  DateTime pickedDataStartFrom;

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  AppLocalizations.of(context).translate('iServe'),
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(17)),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: AppLocalizations.of(context).translate('hospitalName'),
                  hasBorder: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context).translate('fieldRequiredValidate');
                    }
                    return null;
                  },
                  onSaved: (val){
                    hospitalName=val;
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                InkWell(
                  onTap: (){
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
                  child: IgnorePointer(
                    child: CustomTextField(
                      readOnly: true,
                      controller: _controller,
                      filledColor: Colors.white,
                      lablel: AppLocalizations.of(context).translate('startFrom'),
                      hasBorder: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context).translate('fieldRequiredValidate');
                        }
                        return null;
                      },
                      onSaved: (val){
                        startForm=val;
                      },
                      sufficIcon: Icon(
                        Icons.date_range,
                        color: ColorsUtils.blueColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: AppLocalizations.of(context).translate('jobTitle'),
                  hasBorder: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context).translate('fieldRequiredValidate');
                    }
                    return null;
                  },
                  onSaved: (val){
                    jobTitle=val;
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
                          Provider.of<ClinicsProvider>(context,listen: false).addServeClinic(ServingInHealthcare(
                              hospitalName:  hospitalName,
                              hospitalJobTitle:  jobTitle,
                              hospitalStartedFrom: pickedDataStartFrom.toIso8601String(),
                              hospitalPhoneNumber: '01156984563'
                          ));
                          Navigator.pop(context);
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

    );
  }
}
