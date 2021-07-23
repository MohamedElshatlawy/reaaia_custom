import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/model/app_data/details.dart';
import 'package:reaaia/model/data/signup/languages_model.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/home/profile/add_profile/add_language.dart';
import 'package:reaaia/screens/widgets/custom_rounded_button_widget.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/data_provider.dart';

class EditLanguagesPage extends StatefulWidget {
  @override
  _EditLanguagesPageState createState() => _EditLanguagesPageState();
}

class _EditLanguagesPageState extends State<EditLanguagesPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Languages> _languages = [];
  String selectedLanguage;
  String selectedLevelLanguage;

  @override
  void initState() {
    super.initState();
    _languages.add(Languages(languageId: 1,languageLevelId: 2));
    _languages.add(Languages(languageId: 4,languageLevelId: 1));
  }
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorsUtils.borderColor));
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Builder(
        builder: (context) =>  Consumer<DataProvider>(builder: (_, provider, __) {
      final providerData = provider.appDataModel.response.data;
          return  Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ScreenUtil().setHeight(48)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        InkWell(
                          onTap: () async {
                            await showModalBottomSheet(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(24),
                                    topLeft: Radius.circular(24),
                                  )),
                              barrierColor: ColorsUtils.modalSheetBarrierColor,
                              backgroundColor: ColorsUtils.modalSheetBarrierColor,
                              context: context,
                              //isScrollControlled: true,
                              builder: (context) {
                                 return AddLanguage();
                              },
                            );
                            // setState(() {
                            // Provider.of<ClinicsProvider>(context, listen: false)
                            //     .getBranchesData(widget.clinicId);
                            // });
                          },
                          child: Container(
                            //margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.add,
                                color: ColorsUtils.blueColor,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(17)),
                    Row(
                      children: [
                        Text(
                          'Edit Languages',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: ScreenUtil().setSp(24)),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: _languages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          width: ScreenUtil().screenWidth,
                          //height: ScreenUtil().setHeight(250),
                          padding: EdgeInsets.all(18.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: ScreenUtil().setHeight(16)),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Language',
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
                                  _languages[index].languageId = models.id;
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
                                  _languages[index].languageLevelId =
                                      models.id;
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
                              Container(
                                height: ScreenUtil().setHeight(40),
                                child: CustomRoundedButton(
                                  iconLeft: true,
                                  backgroundColor: Colors.red.withOpacity(0.1),
                                  borderColor: Colors.red,
                                  text: 'Remove Language ',
                                  pressed: () {
                                    setState(() {
                                      _languages.add(Languages());
                                    });
                                  },
                                  textColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
    },


      ),
    ),);
  }
}
