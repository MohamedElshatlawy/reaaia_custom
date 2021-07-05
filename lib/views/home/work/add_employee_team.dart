import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

class AddEmployeeTeam extends StatefulWidget {
  @override
  _AddEmployeeTeamState createState() => _AddEmployeeTeamState();
}

class _AddEmployeeTeamState extends State<AddEmployeeTeam> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> jobNature = [
    'Second Doctors',
    'Assistant',
    'Receptionist'
  ];
  final List<String> branches = [
    'Alexandria, Smoha',
    'Cairo, Nasr City',
    'Elbeheira, Damanhur'
  ];

  String selectedJobNature;
  List<String> selectedBranch = [];


  @override
  void initState() {
    super.initState();
    selectedBranch.add('');
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorsUtils.borderColor));
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
                  'Add Employee',
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(17)),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: 'Employee Name',
                  hasBorder: true,
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This Field Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(15)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: 'Phone Number*',
                  hasBorder: true,
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This Field Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(15)),
                DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Select Job Nature!';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Job Nature',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(15)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                  value: selectedJobNature,
                  iconSize: 24,
                  onChanged: (newValue) {
                    setState(() {
                      selectedJobNature = newValue;
                    });
                  },
                  onSaved: (val) {
                    // selectedJobNature = val;
                  },
                  items:
                      jobNature.map<DropdownMenuItem<String>>((String value) {
                    return new DropdownMenuItem(
                      child: new Text(value),
                      value: value,
                    );
                  }).toList(),
                ),
                SizedBox(height: ScreenUtil().setHeight(15)),
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: selectedBranch.length,
                    itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 7.0),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ' Select Branch!';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Branch',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(15)),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                        //value: selectedBranch[index],
                        iconSize: 24,
                        onChanged: (newValue) {
                          setState(() {
                            selectedBranch[index] = newValue;
                            print(selectedBranch.toString());
                          });
                        },
                        onSaved: (val) {
                          // selectedBranch[index] = val;
                        },
                        items: branches.map<DropdownMenuItem<String>>((String value) {
                          return new DropdownMenuItem(
                            child: new Text(value),
                            value: value,
                          );
                        }).toList(),
                      ),
                    );
                    },
                ),

                SizedBox(height: ScreenUtil().setHeight(15)),
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
                    text: 'Add More Branch ',
                    pressed: () {
                      setState(() {
                        selectedBranch.add('');
                      });
                    },
                    textColor: ColorsUtils.primaryGreen,
                  ),
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