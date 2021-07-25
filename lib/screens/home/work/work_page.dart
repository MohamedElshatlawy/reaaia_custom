import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/home/work/clinics/clinics_page.dart';
import 'package:reaaia/screens/widgets/custom_card.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';


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
              AppLocalizations.of(context).translate('myWork'),
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
                CustomCardView(namePic: 'assets/images/003-folder.png',nameText: AppLocalizations.of(context).translate('clinics'),onPressed: (){
                  CustomFunctions.pushScreen(context: context,widget: ClinicsPage());
                },),
                CustomCardView(namePic: 'assets/images/img_health_feed.png',nameText: AppLocalizations.of(context).translate('library'),onPressed: (){},),
                CustomCardView(namePic: 'assets/images/img_consult_mange.png',nameText: AppLocalizations.of(context).translate('appointmentsManagement'),onPressed: (){},),
                CustomCardView(namePic: 'assets/images/img_work_profile.png',nameText: AppLocalizations.of(context).translate('profileManagement'),onPressed: (){},),
                CustomCardView(namePic: 'assets/images/img_health_guide.png',nameText: AppLocalizations.of(context).translate('healthGuides'),onPressed: (){},),
                CustomCardView(namePic: 'assets/images/img_health_tip.png',nameText: AppLocalizations.of(context).translate('healthTips'),onPressed: (){},),
                CustomCardView(namePic: 'assets/images/img_care_team.png',nameText: AppLocalizations.of(context).translate('myNetwork'),onPressed: (){},),
                CustomCardView(namePic: 'assets/images/img_finance_report.png',nameText: AppLocalizations.of(context).translate('financeReport'),onPressed: (){},),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
          ],
        ),
      ),
    );
  }
}