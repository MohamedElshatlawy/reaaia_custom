import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/data/clinicsModel/branch_model.dart';
import 'package:reaaia/repos/clinics_repo.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/home/work/add_appointment_clnic.dart';
import 'package:reaaia/views/home/work/edit_branch_clinic.dart';
import 'package:reaaia/views/widgets/reaaia__icons_icons.dart';

class ClinicAppointments extends StatefulWidget {
  final BranchData branch;

  ClinicAppointments(this.branch);
  @override
  _ClinicAppointmentsState createState() => _ClinicAppointmentsState();
}

class _ClinicAppointmentsState extends State<ClinicAppointments> {

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp)  {
      ClinicsRepository.getBranchDetail(widget.branch.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: ScreenUtil().screenHeight * 0.22,
            color: ColorsUtils.darkGreenColor,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              return AddAppointmentPage();
                            },
                          );

                        },
                        child: Container(
                            height: 40.0,
                            width: 40.0,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: ColorsUtils.lightBlueColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: ColorsUtils.blueColor,
                              ),
                              height: 35.0,
                              width: 35.0,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.branch.city}, ${widget.branch.area}',
                                  style: TextStyle(
                                      color: ColorsUtils.blueColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(16)),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  widget.branch.detailedAddress,
                                  style: TextStyle(
                                      color: ColorsUtils.onBoardingTextGrey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: ScreenUtil().setSp(13)),
                                ),
                              ],
                            ),
                          ],
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
                                return EditBranchClinic(widget.branch);
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: ColorsUtils.lightBlueColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.edit,
                                color: ColorsUtils.primaryGreen,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),

                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 25.0),
                          child: Text(
                            ' Appointments',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(17)),
                          ),
                        ),
                        CustomAppointmentDayView(
                          dayName: 'Saturday',
                          to: '08:00 PM',
                          from: '10:00 PM',
                          duration: '15',
                        ),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                        CustomAppointmentDayView(
                          dayName: 'Sunday',
                          to: '08:00 PM',
                          from: '10:00 PM',
                          duration: '15',
                        ),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                        CustomAppointmentDayView(
                          dayName: 'Monday',
                          to: '08:00 PM',
                          from: '10:00 PM',
                          duration: '15',
                        ),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                        CustomAppointmentDayView(
                          dayName: 'Tuesday',
                          to: '08:00 PM',
                          from: '10:00 PM',
                          duration: '15',
                        ),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                        CustomAppointmentDayView(
                          dayName: 'Wednesday',
                          to: '08:00 PM',
                          from: '10:00 PM',
                          duration: '15',
                        ),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                        CustomAppointmentDayView(
                          dayName: 'Thursday',
                          to: '08:00 PM',
                          from: '10:00 PM',
                          duration: '15',
                        ),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class CustomAppointmentDayView extends StatelessWidget {
  final String dayName;
  final String to;
  final String from;
  final String duration;

  CustomAppointmentDayView({@required this.dayName,@required this.to,@required this.from,@required this.duration});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: ColorsUtils.lightBlueColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Reaaia_Icons.calendr_icon,
                      color: ColorsUtils.primaryGreen,
                    ),
                    height: 35.0,
                    width: 35.0,
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    dayName,
                    style: TextStyle(
                        color: ColorsUtils.textGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(15)),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(
                color: ColorsUtils.lineColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Icon(Icons.circle,size: 9,color: ColorsUtils.blueColor,),
                      SizedBox(width: 5.0,),
                      Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:  '$to - $from',
                                style: TextStyle(
                                    color: ColorsUtils.blueColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(15)),
                              ),
                              TextSpan(
                                text:  ' ($duration Mins)',
                                style: TextStyle(
                                    color: ColorsUtils.onBoardingTextGrey,
                                    fontSize: ScreenUtil().setSp(14)),
                              )
                            ],
                          )
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

