import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/data/clinicsModel/clinics_model.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/home/work/clinic_booking_info.dart';
import 'package:reaaia/views/home/work/clinic_branches.dart';
import 'package:reaaia/views/home/work/clinic_info.dart';
import 'package:reaaia/views/home/work/clinic_services.dart';
import 'package:reaaia/views/home/work/clinic_team.dart';
import 'package:reaaia/views/home/work/custom_container_view.dart';
import 'package:reaaia/views/widgets/reaaia__icons_icons.dart';

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
                                Reaaia_Icons.forward_icon,
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
                              name: 'Patients',
                              numbers: '1,523',
                            ),
                            CustomTextWidget(
                              name: 'Saved lives',
                              numbers: '423',
                            ),
                            CustomTextWidget(
                              name: 'Helped people',
                              numbers: '423.2K',
                            ),
                            CustomTextWidget(
                              name: 'Thanks for',
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
                          onTap: (){
                            CustomFunctions.pushScreen(context: context,widget: ClinicInfoPage());
                          },
                          name: 'Clinic Info',
                          decs: 'Basic Information of Clinic',
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Divider(color: ColorsUtils.lineColor,),
                        ),

                        CustomListTile(
                          onTap: (){
                            CustomFunctions.pushScreen(context: context,widget: ClinicBranches(clinicData.id));

                          },
                          name: 'Branches/Appointments',
                          decs: 'Control branches and appointments',
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Divider(color: ColorsUtils.lineColor,),
                        ),
                        CustomListTile(
                          onTap: (){
                            CustomFunctions.pushScreen(context: context,widget: ClinicServices(clinicData.id));
                          },
                          name: 'Services',
                          decs: 'Clinic main services and offers',
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Divider(color: ColorsUtils.lineColor,),
                        ),
                        CustomListTile(
                          onTap: (){
                            CustomFunctions.pushScreen(context: context,widget: ClinicBookingInfoPage());

                          },
                          name: 'Booking Info',
                          decs: 'Clinic Fees and waiting time',
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Divider(color: ColorsUtils.lineColor,),
                        ),
                        CustomListTile(
                          onTap: (){
                            CustomFunctions.pushScreen(context: context,widget: ClinicTeamPage(clinicData.id));

                          },
                          name: 'Team',
                          decs: 'add / view clinic employees',
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
  CustomListTile({this.onTap,this.name,this.decs});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title:  Text(
        name,
        style: TextStyle(
            color: ColorsUtils.textGrey,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(15)),
      ),
      subtitle:  Text(
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
        child: Icon(Reaaia_Icons.ic_doctor,color: Colors.white,size: 30,),
      ),
      trailing: Icon(Icons.keyboard_arrow_right,color: ColorsUtils.onBoardingTextGrey,),


    );
  }
}

