import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/model/clinics/clinics_model.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/home/work/clinics/booking/clinic_booking_info.dart';
import 'package:reaaia/screens/home/work/clinics/branches_appointments/clinic_branches.dart';
import 'package:reaaia/screens/home/work/clinics/clinic_info/clinic_info.dart';
import 'package:reaaia/screens/home/work/clinics/services/clinic_services.dart';
import 'package:reaaia/screens/home/work/clinics/team/clinic_team.dart';
import 'package:reaaia/screens/home/work/clinics/custom_container_view.dart';

import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/reaaia_icons.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';

class ClinicDetailPage extends StatelessWidget {
  final ClinicData clinicData;

  ClinicDetailPage({@required this.clinicData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: ScreenUtil().screenHeight * 0.35,
              color: ColorsUtils.darkGreenColor,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  SizedBox(height: ScreenUtil().setHeight(40)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            CustomFunctions.popScreen(context);
                          },
                          child: Container(
                              height: 40.0,
                              width: 40.0,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                              height: 40.0,
                              width: 40.0,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                ReaaiaIcons.forward_icon,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        CustomContainerView(
                          imageName: 'assets/images/Hospital Logo.png',
                          docName: clinicData.name,
                          address: 'Allergy & Immunology',
                          rate: 4.8,
                          numOfReviews: 1387,
                          hasBorder: true,
                          hasIcon: true,
                          iconColor: Colors.green,
                        ),
                        Divider(
                          color: ColorsUtils.onBoardingTextGrey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTextWidget(
                              name: AppLocalizations.of(context).translate('patients'),
                              numbers: '1,523',
                            ),
                            CustomTextWidget(
                              name: AppLocalizations.of(context).translate('savedLives'),
                              numbers: '423',
                            ),
                            CustomTextWidget(
                              name: AppLocalizations.of(context).translate('helpedPeople'),
                              numbers: '423.2K',
                            ),
                            CustomTextWidget(
                              name: AppLocalizations.of(context).translate('thanksFor'),
                              numbers: '24.2K',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(5)),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        CustomListTile(
                          onTap: () {
                            CustomFunctions.pushScreen(
                                context: context, widget: ClinicInfoPage());
                          },
                          name: AppLocalizations.of(context).translate('clinicInfo'),
                          decs: AppLocalizations.of(context).translate('clinicInfoDesc'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Divider(
                            color: ColorsUtils.lineColor,
                          ),
                        ),
                        CustomListTile(
                          onTap: () {
                            CustomFunctions.pushScreen(
                                context: context,
                                widget: ClinicBranches(clinicData.id));
                          },
                          name: AppLocalizations.of(context).translate('branch'),
                          decs: AppLocalizations.of(context).translate('branchInfo'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Divider(
                            color: ColorsUtils.lineColor,
                          ),
                        ),
                        CustomListTile(
                          onTap: () {
                            CustomFunctions.pushScreen(
                                context: context,
                                widget: ClinicServices(clinicData.id));
                          },
                          name: AppLocalizations.of(context).translate('services'),
                          decs: AppLocalizations.of(context).translate('servicesInfo'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Divider(
                            color: ColorsUtils.lineColor,
                          ),
                        ),
                        CustomListTile(
                          onTap: () {
                            CustomFunctions.pushScreen(
                                context: context,
                                widget: ClinicBookingInfoPage());
                          },
                          name: AppLocalizations.of(context).translate('booking'),
                          decs: AppLocalizations.of(context).translate('bookingInfo'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Divider(
                            color: ColorsUtils.lineColor,
                          ),
                        ),
                        CustomListTile(
                          onTap: () {
                            CustomFunctions.pushScreen(
                                context: context,
                                widget: ClinicTeamPage(clinicData.id));
                          },
                          name: AppLocalizations.of(context).translate('team'),
                          decs: AppLocalizations.of(context).translate('teamInfo'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(30)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  final String name;
  final String numbers;

  CustomTextWidget({this.name, this.numbers});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
              color: ColorsUtils.onBoardingTextGrey,
              fontWeight: FontWeight.w600,
              fontSize: ScreenUtil().setSp(11)),
        ),
        Text(
          numbers,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(15)),
        ),
      ],
    );
  }
}

class CustomListTile extends StatelessWidget {
  final Function onTap;
  final String name;
  final String decs;
  CustomListTile({this.onTap, this.name, this.decs});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        name,
        style: TextStyle(
            color: ColorsUtils.textGrey,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(15)),
      ),
      subtitle: Text(
        decs,
        style: TextStyle(
            color: ColorsUtils.onBoardingTextGrey,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(11)),
      ),
      leading: Container(
        // padding: EdgeInsets.all(1.0),
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: ColorsUtils.darkGreenColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          ReaaiaIcons.ic_doctor,
          color: Colors.white,
          size: 30,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: ColorsUtils.onBoardingTextGrey,
        size: 18,
      ),
    );
  }
}
