import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';

import '../../customFunctions.dart';
import 'congrats.dart';

class CompleteRequest1Map extends StatelessWidget {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: ScreenUtil().setHeight(40)),
            Image.asset('assets/complete_info1_map.png'),
            Container(
              height: 600,
              width: double.infinity,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
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
                  CustomFunctions.pushScreen(
                      context: context, widget: Congrats());
                },
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
