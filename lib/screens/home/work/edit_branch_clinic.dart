import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/model/app_data/details.dart';
import 'package:reaaia/model/clinics/branchModels/branch_model.dart';
import 'package:reaaia/screens/auth/signup/complete_req1_map.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/Fuctions.dart';
import 'package:reaaia/viewModels/data_provider.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';

class EditBranchClinic extends StatefulWidget {
  final BranchData branchData;
  EditBranchClinic(this.branchData);
  @override
  _EditBranchClinicState createState() => _EditBranchClinicState();
}

class _EditBranchClinicState extends State<EditBranchClinic> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mapController = TextEditingController();
  bool loading = false;
  String selectedCity;
  String selectedCityArea;
  List<Areas> _areas = [];
  LatLng _latLng;

  Map<String, dynamic> _branchInfo = {};

  @override
  void initState() {
    super.initState();
    _mapController.text = widget.branchData.detailedAddress;
    Cities cityModel = Provider.of<DataProvider>(context, listen: false)
        .appDataModel
        .response
        .data
        .cities
        .firstWhere((element) => element.name == widget.branchData.city);
    _areas = cityModel.areas;
    selectedCityArea = widget.branchData.area;
    _branchInfo['latitude'] = widget.branchData.latitude;
    _branchInfo['longitude'] = widget.branchData.longitude;
    _branchInfo['detailed_address'] = widget.branchData.detailedAddress;
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorsUtils.borderColor));
    final clinicProvider = Provider.of<ClinicsProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Consumer<DataProvider>(
        builder: (_, provider, __) {
          final providerData = provider.appDataModel.response.data;
          return Form(
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
                      'Edit Branch',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(17)),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ' Select City!';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'City',
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
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            isExpanded: true,
                            value: widget.branchData.city,
                            iconSize: 24,
                            onChanged: (newValue) {
                              setState(() {
                                //_areas.clear();
                                selectedCityArea = null;
                                selectedCity = newValue;
                                Cities cityModel = providerData.cities
                                    .firstWhere(
                                        (element) => element.name == newValue);
                                _areas = cityModel.areas;
                                print(
                                    newValue + '  ' + cityModel.id.toString());
                              });
                            },
                            onSaved: (val) {
                              selectedCity = val;
                              Cities cityModel = providerData.cities
                                  .firstWhere((element) => element.name == val);
                              _branchInfo['city_id'] = cityModel.id;
                            },
                            items: providerData.cities
                                .map<DropdownMenuItem<String>>((Cities value) {
                              return new DropdownMenuItem(
                                child: new Text(value.name),
                                value: value.name,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(25.0),
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ' Select Area!';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Area',
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
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            isExpanded: true,
                            iconSize: 24,
                            value: selectedCityArea,
                            onChanged: (newValue) {
                              setState(() {
                                selectedCityArea = newValue;
                                print(selectedCityArea);
                                Areas areaModel = _areas.firstWhere((element) =>
                                    element.name == selectedCityArea);
                                _branchInfo['area_id'] = areaModel.id;
                              });
                            },
                            onSaved: (newValue) {
                              Areas areaModel = _areas.firstWhere((element) =>
                                  element.name == selectedCityArea);
                              _branchInfo['area_id'] = areaModel.id;
                            },
                            items: _areas
                                .map<DropdownMenuItem<String>>((Areas value) {
                              return new DropdownMenuItem(
                                child: new Text(value.name),
                                value: value.name,
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => CompleteRequest1Map()))
                            .then((value) {
                          setState(() {
                            _latLng = value as LatLng;
                            print(value.toString());
                            _mapController.text = 'Lat:' +
                                _latLng.latitude.toStringAsFixed(2) +
                                ' Lng:' +
                                _latLng.longitude.toStringAsFixed(2);
                            _branchInfo['latitude'] = _latLng.latitude;
                            _branchInfo['longitude'] = _latLng.longitude;
                            _branchInfo['detailed_address'] = '30 city street';
                          });
                        });
                      },
                      child: IgnorePointer(
                        child: CustomTextField(
                          controller: _mapController,
                          filledColor: Colors.white,
                          lablel: ' Main Address*',
                          hasBorder: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field Required';
                            }
                            return null;
                          },
                          icon: Icon(
                            Icons.location_on_outlined,
                            color: ColorsUtils.blueColor,
                          ),
                          sufficIcon: Icon(
                            Icons.my_location,
                            color: ColorsUtils.onBoardingTextGrey,
                          ),
                        ),
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
                                    print(_branchInfo.toString());
                                    setState(() {
                                      loading = true;
                                    });
                                    try {
                                      final status =
                                          await clinicProvider.editBranchClinic(
                                              widget.branchData.id,
                                              _branchInfo);
                                      if (status == 200) {
                                        setState(() {
                                          loading = false;
                                        });
                                        Navigator.pop(context);
                                        Navigator.pop(context);
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
                                        text: 'The given data  invalid!',
                                        hasIcon: true,
                                        iconType: Icons.error_outline,
                                        iconColor: Colors.red,
                                      );
                                    }
                                  } else {}
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
          );
        },
      ),
    );
  }
}
