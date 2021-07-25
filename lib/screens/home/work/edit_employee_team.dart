import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/model/clinics/branchModels/branch_model.dart';
import 'package:reaaia/model/clinics/teamModels/job_natures.dart';
import 'package:reaaia/model/clinics/teamModels/team.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';

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
  // final List<String> branches = [
  //   'Alexandria, Smoha',
  //   'Cairo, Nasr City',
  //   'Elbeheira, Damanhur'
  // ];

  String selectedJobNature;
  List<int> selectedBranch = [];
  List<Branches> _branches = [];

  @override
  void initState() {
    super.initState();
    _branches = widget.teamDataModel.branches;
    _branches.map((e) => selectedBranch.add(e.id)).toList();
    print(selectedBranch.toString());
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
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      _teamInfo['name'] = val;
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
                    initialValue: widget.teamDataModel.mobileNumber,
                    filledColor: Colors.white,
                    lablel: 'Phone Number*',
                    hasBorder: true,
                    onSaved: (val) {
                      _teamInfo['mobile_number'] = val;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field Required';
                      } else if (value.length != 11) {
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
                    value: widget.teamDataModel.jobNature.first.jobNature,
                    iconSize: 24,
                    onChanged: (newValue) {
                      setState(() {
                        selectedJobNature = newValue;
                      });
                    },
                    onSaved: (val) {
                      selectedJobNature = val;
                      _teamInfo['job_nature'] = val;
                    },
                    items: provider.jobNatures
                        .map<DropdownMenuItem<String>>((JobNaturesData value) {
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
                          value: selectedBranch[index].toString(),
                          iconSize: 24,
                          onChanged: (newValue) {
                            setState(() {
                              selectedBranch[index] = int.tryParse(newValue);
                              print(selectedBranch.toString());
                            });
                          },
                          onSaved: (val) {
                            setState(() {
                              selectedBranch[index] = int.tryParse(val);
                              _teamInfo['branches'] = selectedBranch;
                            });
                          },
                          items: provider.branches
                              .map<DropdownMenuItem<String>>(
                                  (BranchData value) {
                            return new DropdownMenuItem(
                              child: new Text(value.city + ', ' + value.area),
                              value: value.id.toString(),
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
                          selectedBranch.add(provider.branches.first.id);
                          print(selectedBranch.toString());
                        });
                      },
                      textColor: ColorsUtils.primaryGreen,
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  loading
                      ? Center(child: CircularProgressIndicator())
                      : Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: ScreenUtil().setHeight(50),
                            width: 236,
                            child: CustomRoundedButton(
                              backgroundColor: ColorsUtils.primaryGreen,
                              borderColor: ColorsUtils.primaryGreen,
                              text: 'Save',
                              pressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  print(_teamInfo.toString());
                                  setState(() {
                                    loading = true;
                                  });
                                  try {
                                    final response =
                                        await provider.editTeamMember(
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
