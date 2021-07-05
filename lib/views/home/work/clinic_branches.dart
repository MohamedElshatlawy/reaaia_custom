import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/home/work/add_branch_clinic.dart';
import 'package:reaaia/views/home/work/clinic_appointments.dart';

class ClinicBranches extends StatefulWidget {
  @override
  _ClinicBranchesState createState() => _ClinicBranchesState();
}

class _ClinicBranchesState extends State<ClinicBranches> {
  @override
  Widget build(BuildContext context) {
    final branches = Provider.of<ClinicsProvider>(context).branches;
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Container(
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
                          return AddBranchClinic();
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
              SizedBox(height: ScreenUtil().setHeight(17)),
              Row(
                children: [
                  Text(
                    'Branches',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: ScreenUtil().setSp(24)),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(7)),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Select branch you want to add its appointments.',
                      style: TextStyle(
                          color: ColorsUtils.onBoardingTextGrey,
                          fontSize: ScreenUtil().setSp(13)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(14)),
              branches.length == 0
                  ? Center(
                      child: Text('No Branches Found '),
                    )
                  : ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: branches.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.only(bottom: 15.0),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: InkWell(
                            onTap: (){
                              CustomFunctions.pushScreen(context: context,widget: ClinicAppointments(branches[index]));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: ColorsUtils.lightBlueColor,
                                            borderRadius:
                                                BorderRadius.circular(8)),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${branches[index].city}, ${branches[index].area}',
                                            style: TextStyle(
                                                color: ColorsUtils.blueColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: ScreenUtil().setSp(16)),
                                          ),
                                          SizedBox(height: 5.0,),
                                          Text(
                                            branches[index].address,
                                            style: TextStyle(
                                                color: ColorsUtils
                                                    .onBoardingTextGrey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: ScreenUtil().setSp(13)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 25.0,vertical: 7.0),
                                    child: Divider(color: ColorsUtils.lineColor,),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Branch Status',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: ScreenUtil().setSp(13)),
                                          ),
                                          Text(
                                            'Available to receive appointments',
                                            style: TextStyle(
                                                color: ColorsUtils
                                                    .onBoardingTextGrey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: ScreenUtil().setSp(13)),
                                          ),
                                        ],
                                      ),
                                      CupertinoSwitch(value: true,
                                          onChanged: (val){},
                                      activeColor: ColorsUtils.primaryGreen,)
                                    ],
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
