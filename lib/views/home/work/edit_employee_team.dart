import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/data/clinicsModel/teamModels/job_natures_model.dart';
import 'package:reaaia/data/clinicsModel/teamModels/team_model.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';
import 'package:reaaia/views/widgets/custom_textfield.dart';

class EditEmployeeTeam extends StatefulWidget {
  final TeamDataModel teamDataModel;
  EditEmployeeTeam(this.teamDataModel);

  @override
  _EditEmployeeTeamState createState() => _EditEmployeeTeamState();
}

class _EditEmployeeTeamState extends State<EditEmployeeTeam> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  Map<String, dynamic> _teamInfo = {};
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
      child: Consumer<ClinicsProvider>(
        builder: (_, provider, __) => Form(
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
                    'Edit Employee',
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(17)),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  CustomTextField(
                    initialValue: widget.teamDataModel.name,
                    filledColor: Colors.white,
                    lablel: 'Employee Name',
                    hasBorder: true,
                    onSaved: (val) {
                      _teamInfo['name']=val;
                    },
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
                    onSaved: (val) {
                      _teamInfo['mobile_number']=val;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field Required';
                      }else if (value.length != 11) {
                        return 'this Field Should no less than 11 digits';
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
                    value: widget.teamDataModel.jobNature.first,
                    iconSize: 24,
                    onChanged: (newValue) {
                      setState(() {
                        selectedJobNature = newValue;
                      });
                    },
                    onSaved: (val) {
                      selectedJobNature = val;
                      _teamInfo['job_nature']=val;
                    },
                    items:
                    provider.jobNatures.map<DropdownMenuItem<String>>((JobNaturesData value) {
                      return new DropdownMenuItem(
                        child: new Text(value.jobNatureName),
                        value: value.jobNature,
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
                            _teamInfo['branches']=[2,4];
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
                  loading?Center(child: CircularProgressIndicator()):     Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: ScreenUtil().setHeight(50),
                      width: 236,
                      child: CustomRoundedButton(
                        backgroundColor: ColorsUtils.primaryGreen,
                        borderColor: ColorsUtils.primaryGreen,
                        text: 'Save',
                        pressed: ()async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            print(_teamInfo.toString());
                            setState(() {
                              loading = true;
                            });
                            try {
                              final response=  await provider.editTeamMember(
                                  widget.teamDataModel.id, _teamInfo);
                              if (response == 200) {
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pop(context);
                              } else {
                                setState(() {
                                  loading = false;
                                });
                                // Functions.showCustomSnackBar(
                                //   context: context,
                                //   text: 'The given data was invalid!',
                                //   hasIcon: true,
                                //   iconType: Icons.error_outline,
                                //   iconColor: Colors.red,
                                // );
                              }
                            } catch (err) {
                              log(err.toString());
                              setState(() {
                                loading = false;
                              });
                              // Functions.showCustomSnackBar(
                              //   context: context,
                              //   text: 'The given data  invalid!',
                              //   hasIcon: true,
                              //   iconType: Icons.error_outline,
                              //   iconColor: Colors.red,
                              // );
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
    );
  }
}
