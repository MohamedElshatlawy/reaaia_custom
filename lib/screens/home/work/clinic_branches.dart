import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/home/work/add_branch_clinic.dart';
import 'package:reaaia/screens/home/work/clinic_appointments.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';

class ClinicBranches extends StatefulWidget {
  final int clinicId;

  ClinicBranches(this.clinicId);
  @override
  _ClinicBranchesState createState() => _ClinicBranchesState();
}

class _ClinicBranchesState extends State<ClinicBranches> {
  bool loading;
  List<bool> toggleStatus = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<ClinicsProvider>(context, listen: false)
          .getBranchesData(widget.clinicId);
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final branches = Provider.of<ClinicsProvider>(context).branches;
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Builder(
        builder: (context) => Container(
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
                            return AddBranchClinic(widget.clinicId);
                          },
                        );
                        setState(() {
                          Provider.of<ClinicsProvider>(context, listen: false)
                              .getBranchesData(widget.clinicId);
                        });
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
                loading
                    ? Container(
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.3),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Consumer<ClinicsProvider>(
                        builder: (_, clinicsProvider, __) {
                        clinicsProvider.branches.map((e) {
                          toggleStatus.add(e.status);
                        }).toList();
                        return clinicsProvider.branches.length == 0
                            ? Center(
                                child: Text('No Branches Found '),
                              )
                            : ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: clinicsProvider.branches.length,
                                itemBuilder: (context, index) {
                                  //toggleStatus[index]=clinicsProvider.branches[index].status;
                                  return Dismissible(
                                    key: Key(clinicsProvider.branches[index].id
                                        .toString()),
                                    direction: DismissDirection.endToStart,
                                    confirmDismiss: (dir) {
                                      return showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                              title: Text('Are you Sure ?'),
                                              content: Text(
                                                  'Do you want to remove  This Branch from your Branches ?'),
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, false);
                                                    },
                                                    child: Text('No')),
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, true);
                                                    },
                                                    child: Text('Yes')),
                                              ],
                                            );
                                          });
                                    },
                                    onDismissed: (dir) {
                                      Provider.of<ClinicsProvider>(context,
                                              listen: false)
                                          .deleteBranches(
                                              clinicsProvider
                                                  .branches[index].id,
                                              index);
                                    },
                                    background: Container(
                                      margin: EdgeInsets.only(bottom: 20.0),
                                      padding: EdgeInsets.only(right: 30.0),
                                      color: Theme.of(context).errorColor,
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 40.0,
                                      ),
                                    ),
                                    child: Card(
                                      margin: EdgeInsets.only(bottom: 15.0),
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          // CustomFunctions.pushScreen(
                                          //     context: context,
                                          //     widget: ClinicAppointments(clinicsProvider.branches[index]));
                                          Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          ClinicAppointments(
                                                              clinicsProvider
                                                                      .branches[
                                                                  index])))
                                              .then((value) {
                                            setState(() {
                                              Provider.of<ClinicsProvider>(
                                                      context,
                                                      listen: false)
                                                  .getBranchesData(
                                                      widget.clinicId);
                                            });
                                          });
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
                                                        color: ColorsUtils
                                                            .lightBlueColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color:
                                                          ColorsUtils.blueColor,
                                                    ),
                                                    height: 35.0,
                                                    width: 35.0,
                                                  ),
                                                  SizedBox(
                                                    width: 15.0,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${clinicsProvider.branches[index].city}, ${clinicsProvider.branches[index].area}',
                                                        style: TextStyle(
                                                            color: ColorsUtils
                                                                .blueColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(16)),
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        clinicsProvider
                                                            .branches[index]
                                                            .detailedAddress,
                                                        style: TextStyle(
                                                            color: ColorsUtils
                                                                .onBoardingTextGrey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(13)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 25.0,
                                                    vertical: 7.0),
                                                child: Divider(
                                                  color: ColorsUtils.lineColor,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Branch Status',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(13)),
                                                      ),
                                                      Text(
                                                        'Available to receive appointments',
                                                        style: TextStyle(
                                                            color: ColorsUtils
                                                                .onBoardingTextGrey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(13)),
                                                      ),
                                                    ],
                                                  ),
                                                  CupertinoSwitch(
                                                    value: toggleStatus[index],
                                                    onChanged: (val) {
                                                      setState(() {
                                                        toggleStatus[index] =
                                                            !toggleStatus[
                                                                index];
                                                        clinicsProvider
                                                            .toggleStatusBranchClinic(
                                                                clinicsProvider
                                                                    .branches[
                                                                        index]
                                                                    .id);
                                                      });
                                                    },
                                                    activeColor: ColorsUtils
                                                        .primaryGreen,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                      }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
