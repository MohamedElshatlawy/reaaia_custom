import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/model/app_data/details.dart';

import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Constants.dart';
import 'package:reaaia/viewModels/data_provider.dart';

class AddLanguage extends StatefulWidget {
  @override
  _AddLanguageState createState() => _AddLanguageState();
}

class _AddLanguageState extends State<AddLanguage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String selectedLanguage;
  String selectedLevelLanguage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<DataProvider>(builder: (_, provider, __) {
      final providerData = provider.appDataModel.response.data;
      return Form(
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
                  'Add Language',
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(17)),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Language',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(15)),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    border: Constants.border,
                    disabledBorder: Constants.border,
                    enabledBorder: Constants.border,
                    errorBorder: Constants.border,
                    focusedBorder: Constants.border,
                    focusedErrorBorder: Constants.border,
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  style: TextStyle(
                      color: ColorsUtils.blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(16)),
                  icon: const Icon(
                      Icons.keyboard_arrow_down_outlined),
                  isExpanded: true,
                  //value: providerData.languages.where((element) => element.id==_languages[index].languageId).toList()[index].name,
                  iconSize: 24,
                  onChanged: (newValue) {
                    setState(() {
                      selectedLanguage = newValue;
                      // print(selectedLanguage.toString());
                    });
                  },
                  onSaved: (val) {
                    MainModel models = providerData.languages
                        .firstWhere(
                            (element) => element.name == val);
                    print(val + '  ' + models.id.toString());
                    //_languages[index].languageId = models.id;
                  },
                  items: providerData.languages
                      .map<DropdownMenuItem<String>>(
                          (MainModel value) {
                        return new DropdownMenuItem(
                          child: new Text(value.name),
                          value: value.name,
                        );
                      }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select Language';
                    }
                    return null;
                  },
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
                    border: Constants.border,
                    disabledBorder: Constants.border,
                    enabledBorder: Constants.border,
                    errorBorder: Constants.border,
                    focusedBorder: Constants.border,
                    focusedErrorBorder: Constants.border,
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  style: TextStyle(
                      color: ColorsUtils.blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(16)),
                  icon: const Icon(
                      Icons.keyboard_arrow_down_outlined),
                  isExpanded: true,
                  //value: selectedLevelLanguage,
                  iconSize: 24,
                  onChanged: (newValue) {
                    setState(() {
                      selectedLevelLanguage = newValue;
                    });
                  },
                  onSaved: (val) {
                    MainModel models = providerData
                        .languageLevels
                        .firstWhere(
                            (element) => element.name == val);
                    print(val + '  ' + models.id.toString());
                    //_languages[index].languageLevelId = models.id;
                  },
                  items: providerData.languageLevels
                      .map<DropdownMenuItem<String>>(
                          (MainModel value) {
                        return new DropdownMenuItem(
                          child: new Text(value.name),
                          value: value.name,
                        );
                      }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select Level Of Language';
                    }
                    return null;
                  },
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
                      text: 'Add',
                      pressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Navigator.pop(context);
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
      );

      },

      ),
    );
  }
}
