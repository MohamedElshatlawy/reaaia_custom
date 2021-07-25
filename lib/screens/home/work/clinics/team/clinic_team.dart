import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/home/work/clinics/team/add_employee_team.dart';
import 'package:reaaia/screens/home/work/clinics/team/edit_employee_team.dart';
import 'package:reaaia/screens/home/work/clinics/team/filter_team_clinic.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/reaaia_icons.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';
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
      final clinicProvider =
          Provider.of<ClinicsProvider>(context, listen: false);
      await clinicProvider.getTeamData(widget.clinicId);
      await clinicProvider.getTeamDataByBranch(widget.clinicId);
      await clinicProvider.getTeamDataByJonNature(widget.clinicId);
      await clinicProvider.getBranchesData(widget.clinicId);

      await clinicProvider.getJobNaturesData();
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final clinicProvider = Provider.of<ClinicsProvider>(context);
    final teams = clinicProvider.teams;
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
                              return FilterTeamClinicPage();
                            },
                          );
                          await clinicProvider.getTeamData(widget.clinicId);
                          await clinicProvider
                              .getTeamDataByBranch(widget.clinicId);
                          await clinicProvider
                              .getTeamDataByJonNature(widget.clinicId);
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
                              ReaaiaIcons.filter_team_icon,
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
                          await clinicProvider.getTeamData(widget.clinicId);
                          await clinicProvider
                              .getTeamDataByBranch(widget.clinicId);
                          await clinicProvider
                              .getTeamDataByJonNature(widget.clinicId);
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
                    AppLocalizations.of(context).translate('team'),
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
                  : clinicProvider.isSortedByBranch == null
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: teams.length == 0
                              ? Center(
                                  child: Container(
                                    child: Text(
                                      AppLocalizations.of(context).translate('noTeam'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.only(bottom: 20.0),
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: teams.length,
                                  itemBuilder: (context, index) {
                                    return Dismissible(
                                      key: Key(teams[index].id.toString()),
                                      direction: DismissDirection.endToStart,
                                      confirmDismiss: (dir) {
                                        return showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return AlertDialog(
                                                title: Text(AppLocalizations.of(context).translate('areYouSure'),),
                                                content: Text(
                                                  AppLocalizations.of(context).translate('doYouWantRemove'),),
                                                actions: [
                                                  FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, false);
                                                      },
                                                      child: Text(AppLocalizations.of(context).translate('no'),)),
                                                  FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, true);
                                                      },
                                                      child: Text(AppLocalizations.of(context).translate('yes'),)),
                                                ],
                                              );
                                            });
                                      },
                                      onDismissed: (dir) async {
                                        await Provider.of<ClinicsProvider>(
                                                context,
                                                listen: false)
                                            .deleteTeamMember(
                                                teams[index].id, index);
                                      },
                                      background: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0),
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
                                        margin: EdgeInsets.symmetric(
                                          vertical: 7.0,
                                        ),
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            await showModalBottomSheet(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                topRight: Radius.circular(24),
                                                topLeft: Radius.circular(24),
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
                                            await clinicProvider
                                                .getTeamData(widget.clinicId);
                                            await clinicProvider
                                                .getTeamDataByBranch(
                                                    widget.clinicId);
                                            await clinicProvider
                                                .getTeamDataByJonNature(
                                                    widget.clinicId);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 20.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(5.0),
                                                  width:
                                                      ScreenUtil().screenWidth *
                                                          0.2,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Colors.grey[300]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
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
                                                        teams[index].name,
                                                        style: TextStyle(
                                                            color: ColorsUtils
                                                                .blueColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(16)),
                                                      ),
                                                      Text(
                                                        teams[index]
                                                            .jobNature
                                                            .first
                                                            .jobNatureName,
                                                        style: TextStyle(
                                                            color: ColorsUtils
                                                                .textGrey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(14)),
                                                      ),
                                                      Text(
                                                        teams[index]
                                                                .branches
                                                                .first
                                                                .city +
                                                            ', ' +
                                                            teams[index]
                                                                .branches
                                                                .first
                                                                .area,
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
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: clinicProvider.isSortedByBranch
                                ? clinicProvider
                                    .sortBranchModel.response.data.length
                                : clinicProvider
                                    .sortJobNatureModel.response.data.length,
                            itemBuilder: (context, index) {
                              final sortTeam = clinicProvider.isSortedByBranch
                                  ? clinicProvider
                                      .sortBranchModel.response.data[index].team
                                  : clinicProvider.sortJobNatureModel.response
                                      .data[index].team;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (sortTeam.isNotEmpty)
                                    Text(
                                      clinicProvider.isSortedByBranch
                                          ? clinicProvider.sortBranchModel
                                              .response.data[index].branch
                                          : clinicProvider.sortJobNatureModel
                                              .response.data[index].jobNature,
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  if (sortTeam.isNotEmpty)
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                  // teams.length == 0
                                  //     ? Center(
                                  //         child: Container(
                                  //           child: Text(
                                  //             'No Team found',
                                  //             textAlign: TextAlign.center,
                                  //           ),
                                  //         ),
                                  //       )
                                  //     :
                                  ListView.builder(
                                    padding: EdgeInsets.only(bottom: 20.0),
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: sortTeam.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        key: Key(sortTeam[index].id.toString()),
                                        direction: DismissDirection.endToStart,
                                        confirmDismiss: (dir) {
                                          return showDialog(
                                              context: context,
                                              builder: (ctx) {
                                                return AlertDialog(
                                                  title: Text(AppLocalizations.of(context).translate('areYouSure'),),
                                                  content: Text(
                                                    AppLocalizations.of(context).translate('doYouWantRemove'),),
                                                  actions: [
                                                    FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, false);
                                                        },
                                                        child: Text(AppLocalizations.of(context).translate('no'),)),
                                                    FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, true);
                                                        },
                                                        child: Text(AppLocalizations.of(context).translate('yes'),)),
                                                  ],
                                                );
                                              });
                                        },
                                        onDismissed: (dir) async {
                                          await Provider.of<ClinicsProvider>(
                                                  context,
                                                  listen: false)
                                              .deleteTeamMember(
                                                  sortTeam[index].id, index);
                                          sortTeam.removeAt(index);
                                        },
                                        background: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.0),
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
                                          margin: EdgeInsets.symmetric(
                                            vertical: 7.0,
                                          ),
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              await showModalBottomSheet(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                  topRight: Radius.circular(24),
                                                  topLeft: Radius.circular(24),
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
                                              await clinicProvider
                                                  .getTeamData(widget.clinicId);
                                              await clinicProvider
                                                  .getTeamDataByBranch(
                                                      widget.clinicId);
                                              await clinicProvider
                                                  .getTeamDataByJonNature(
                                                      widget.clinicId);
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
                                                          color:
                                                              Colors.grey[300]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
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
                                                          sortTeam[index].name,
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
                                                          sortTeam[index]
                                                              .jobNature
                                                              .first
                                                              .jobNatureName,
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
                                                          sortTeam[index]
                                                                  .branches
                                                                  .first
                                                                  .city +
                                                              ', ' +
                                                              sortTeam[index]
                                                                  .branches
                                                                  .first
                                                                  .area,
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
