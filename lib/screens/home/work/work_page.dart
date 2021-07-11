import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/home/work/clinics_page.dart';
import 'package:reaaia/screens/widgets/custom_card.dart';


class WorkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil().setHeight(48)),
            Text(
              ' My Work ',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(24)),
            ),
            GridView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.05,
                  crossAxisCount: 2,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 7),
              children: [
                CustomCardView(namePic: 'assets/images/003-folder.png',nameText: 'Clinics',onPressed: (){
                  CustomFunctions.pushScreen(context: context,widget: ClinicsPage());
                },),
                CustomCardView(namePic: 'assets/images/img_health_feed.png',nameText: 'Library',onPressed: (){},),
                CustomCardView(namePic: 'assets/images/img_consult_mange.png',nameText: 'Appointments Management',onPressed: (){},),
                CustomCardView(namePic: 'assets/images/img_work_profile.png',nameText: 'Profile Management',onPressed: (){},),
                CustomCardView(namePic: 'assets/images/img_health_guide.png',nameText: 'Health Guides',onPressed: (){},),
                CustomCardView(namePic: 'assets/images/img_health_tip.png',nameText: 'Health Tips',onPressed: (){},),
                CustomCardView(namePic: 'assets/images/img_care_team.png',nameText: 'My Network',onPressed: (){},),
                CustomCardView(namePic: 'assets/images/img_finance_report.png',nameText: 'Finance Report',onPressed: (){},),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
          ],
        ),
      ),
    );
  }
}