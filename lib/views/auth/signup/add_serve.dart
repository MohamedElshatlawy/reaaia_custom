import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/data/signupModels/serve_model.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/sign_up_provider.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

class AddServe extends StatefulWidget {
  @override
  _AddServeState createState() => _AddServeState();
}

class _AddServeState extends State<AddServe> {
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
                    'I Serve',
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(17)),
                  ),
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
                           if (_formKey.currentState.validate()) {
                             _formKey.currentState.save();
                             Provider.of<SignUpProvider>(context,listen: false).addServe(ServeModel(
                               hospitalName: hospitalName,
                               jobTitle: jobTitle,
                               startedFrom: pickedDataStartFrom,
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
