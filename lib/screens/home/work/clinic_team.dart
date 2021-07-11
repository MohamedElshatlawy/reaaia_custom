import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/home/work/add_employee_team.dart';
import 'package:reaaia/screens/home/work/edit_employee_team.dart';
import 'package:reaaia/screens/home/work/filter_team_clinic.dart';
import 'package:reaaia/screens/widgets/reaaia__icons_icons.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';


class ClinicTeamPage extends StatefulWidget {
  final int clinicId;

  ClinicTeamPage(this.clinicId);

  @override
  _ClinicTeamPageState createState() => _ClinicTeamPageState();
}

class _ClinicTeamPageState extends State<ClinicTeamPage> {
  final List<String> _list = [
    '',
    '',
    '',
  ];
  bool loading;

  @override
  void initState() {
    super.initState();

    setState(() {
      loading = true;
    });
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<ClinicsProvider>(context, listen: false)
          .getTeamData(widget.clinicId);
      await Provider.of<ClinicsProvider>(context, listen: false)
          .getJobNaturesData();
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final clinicProvider = Provider.of<ClinicsProvider>(context);
    final teams = clinicProvider.teams;
    final jobNatures=clinicProvider.jobNatures;
    //final teams = clinicProvider.teams.where((element) =>  element.jobNature.first=='receptionist').toList();

    // final sortByJobNature=teams.where((element) {
    //   element.jobNature=jobNatures.r
    // }).toList();
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                      SizedBox(
                        width: 8.0,
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
                            isScrollControlled: true,
                            builder: (context) {
                              return AddEmployeeTeam(widget.clinicId);
                            },
                          );
                          setState(() {
                            Provider.of<ClinicsProvider>(context, listen: false)
                                .getTeamData(widget.clinicId);
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
              SizedBox(height: ScreenUtil().setHeight(18)),
              loading
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.3),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 20.0),
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: jobNatures.length,
                        itemBuilder: (context, index) {
                        final sortTeams=  teams.where((element) =>  element.jobNature.contains(jobNatures[index].jobNature)).toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                jobNatures[index].jobNatureName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(17)),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(20)),
                              sortTeams.length == 0
                                  ? Container(
                                      child: Text(
                                        'No Team found',
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.only(bottom: 20.0),
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: sortTeams.length,
                                      itemBuilder: (context, index) {
                                        return Dismissible(
                                          key: Key(teams[index].id.toString()),
                                          direction:
                                              DismissDirection.endToStart,
                                          confirmDismiss: (dir) {
                                            return showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return AlertDialog(
                                                    title:
                                                        Text('Are you Sure ?'),
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
                                          onDismissed: (dir) async {
                                            await Provider.of<ClinicsProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteTeamMember(
                                                sortTeams[index].id, index);
                                          },
                                          background: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            padding:
                                                EdgeInsets.only(right: 30.0),
                                            color: Theme.of(context).errorColor,
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 40.0,
                                            ),
                                          ),
                                          child: Card(
                                            margin: EdgeInsets.symmetric(
                                              vertical: 7.0,
                                            ),
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(24),
                                                    topLeft:
                                                        Radius.circular(24),
                                                  )),
                                                  barrierColor: ColorsUtils
                                                      .modalSheetBarrierColor,
                                                  backgroundColor: ColorsUtils
                                                      .modalSheetBarrierColor,
                                                  context: context,
                                                  isScrollControlled: true,
                                                  builder: (context) {
                                                    return EditEmployeeTeam(
                                                        teams[index]);
                                                  },
                                                );
                                                setState(() {
                                                  Provider.of<ClinicsProvider>(
                                                          context,
                                                          listen: false)
                                                      .getTeamData(
                                                          widget.clinicId);
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 20.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      width: ScreenUtil()
                                                              .screenWidth *
                                                          0.2,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey[300]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
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
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            sortTeams[index].name,
                                                            style: TextStyle(
                                                                color: ColorsUtils
                                                                    .blueColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            16)),
                                                          ),
                                                          Text(
                                                            sortTeams[index]
                                                                .jobNature
                                                                .first,
                                                            style: TextStyle(
                                                                color: ColorsUtils
                                                                    .textGrey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            14)),
                                                          ),
                                                          Text(
                                                            'Cairo, Nasr City',
                                                            style: TextStyle(
                                                                color: ColorsUtils
                                                                    .onBoardingTextGrey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            13)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
