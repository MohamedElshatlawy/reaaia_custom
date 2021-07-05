import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/home/work/add_employee_team.dart';
import 'package:reaaia/views/home/work/edit_employee_team.dart';
import 'package:reaaia/views/home/work/filter_team_clinic.dart';
import 'package:reaaia/views/widgets/reaaia__icons_icons.dart';

class ClinicTeamPage extends StatelessWidget {
  final List<String> _list = ['','','',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
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
                  Row(
                    children: [
                      InkWell(
                        onTap: () {

                          showModalBottomSheet(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  topLeft: Radius.circular(24),
                                )),
                            barrierColor: ColorsUtils.modalSheetBarrierColor,
                            backgroundColor: ColorsUtils.modalSheetBarrierColor,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return FilterTeamClinicPage();
                            },
                          );
                        },
                        child: Container(
                          height: 35.0,
                          width: 35.0,
                          //margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Reaaia_Icons.filter_team_icon,
                              color: ColorsUtils.blueColor,
                              size: 20,
                            )),
                      ),
                      SizedBox(width: 8.0,),
                      InkWell(
                        onTap: () {

                          showModalBottomSheet(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  topLeft: Radius.circular(24),
                                )),
                            barrierColor: ColorsUtils.modalSheetBarrierColor,
                            backgroundColor: ColorsUtils.modalSheetBarrierColor,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return AddEmployeeTeam();
                            },
                          );
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
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(18)),
              Row(
                children: [
                  Text(
                    'Team',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: ScreenUtil().setSp(24)),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              _list.length == 0
                  ? Container(
                      child: Text(
                        'No Team found',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin:  EdgeInsets.symmetric(vertical: 7.0,),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: InkWell(
                            onTap: (){
                              showModalBottomSheet(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(24),
                                      topLeft: Radius.circular(24),
                                    )),
                                barrierColor: ColorsUtils.modalSheetBarrierColor,
                                backgroundColor: ColorsUtils.modalSheetBarrierColor,
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return EditEmployeeTeam();
                                },
                              );

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    width: ScreenUtil().screenWidth * 0.2,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Image.asset(
                                      'assets/onBoarding/onboard_index1.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mohamed Ahmed',
                                          style: TextStyle(
                                              color: ColorsUtils.blueColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenUtil().setSp(16)),
                                        ),
                                        Text(
                                          'Second Doctor',
                                          style: TextStyle(
                                              color: ColorsUtils.textGrey,
                                              fontWeight: FontWeight.w600,
                                              fontSize: ScreenUtil().setSp(14)),
                                        ),
                                        Text(
                                          'Cairo, Nasr City',
                                          style: TextStyle(
                                              color: ColorsUtils.onBoardingTextGrey,
                                              fontWeight: FontWeight.w600,
                                              fontSize: ScreenUtil().setSp(13)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
