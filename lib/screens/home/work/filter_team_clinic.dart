import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/widgets/reaaia__icons_icons.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';


class FilterTeamClinicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: ScreenUtil().screenWidth,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24.0),
              topLeft: Radius.circular(24.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: (){
                  Provider.of<ClinicsProvider>(context, listen: false).isSortedByBranch=true;
                  CustomFunctions.popScreen(context);
                  },
                leading:  Icon(Reaaia_Icons.filter_team_icon,size: 22,color: ColorsUtils.primaryGreen,),
                title: Text('Sort by branches',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600,color: ColorsUtils.textGrey),),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(color: ColorsUtils.lineColor,),
              ),
              ListTile(
                onTap: (){
                  Provider.of<ClinicsProvider>(context, listen: false).isSortedByBranch=false;
                  CustomFunctions.popScreen(context);
                },
                leading: Icon(Reaaia_Icons.filter_team_icon,size: 22,color: ColorsUtils.primaryGreen,),
                title: Text('Sort by job nature',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600,color: ColorsUtils.textGrey),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
