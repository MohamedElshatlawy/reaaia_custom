import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/widgets/custom_rounded_button_widget.dart';
import 'package:reaaia/screens/widgets/custom_textfield_widget.dart';
import 'package:reaaia/utils/ColorsUtils.dart';

// ignore: must_be_immutable
class CompleteRequest1Map extends StatelessWidget {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  LatLng latLng;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: ScreenUtil().setHeight(40)),
            // Image.asset('assets/complete_info1_map.png'),
            SizedBox(height: ScreenUtil().setHeight(48)),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Icons.clear,
                          color: ColorsUtils.blackColor,
                        )),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Expanded(
                    child: CustomTextField(
                      filledColor: ColorsUtils.containerHealthCareColor,
                      lablel: ' Enter address or zip code...',
                      hasBorder: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field Required';
                        }
                        return null;
                      },
                      sufficIcon: Icon(
                        Icons.my_location,
                        color: ColorsUtils.primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
              child: Row(
                children: [
                  Container(
                    height: ScreenUtil().setHeight(40),
                    width: ScreenUtil().setWidth(40),
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: ColorsUtils.primaryGreen,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(15)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Location',
                        style: TextStyle(
                            color: ColorsUtils.primaryGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(13)),
                      ),
                      Text(
                        '150 Greene St, New York, NY 10012',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(15)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Container(
              height: 480,
              width: double.infinity,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onTap: (val) {
                  latLng = val;
                  print(latLng.latitude);
                  print(latLng.longitude);
                },
                onMapCreated: (GoogleMapController controller) {
                  //_controller.complete(controller);
                },
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Container(
              height: ScreenUtil().setHeight(50),
              width: 236,
              child: CustomRoundedButton(
                backgroundColor: ColorsUtils.primaryGreen,
                borderColor: ColorsUtils.primaryGreen,
                text: 'Choose Location',
                pressed: () {
                  Navigator.pop(context, latLng);
                },
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
          ],
        ),
      ),
    );
  }
}
