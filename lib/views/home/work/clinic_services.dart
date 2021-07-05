import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/home/work/add_service_clinic.dart';
import 'package:reaaia/views/home/work/clinic_service_detail.dart';
import 'package:reaaia/views/widgets/reaaia__icons_icons.dart';

class ClinicServices extends StatefulWidget {
  @override
  _ClinicServicesState createState() => _ClinicServicesState();
}

class _ClinicServicesState extends State<ClinicServices> {

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<ClinicsProvider>(context).services;
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
                      CustomFunctions.pushScreen(context: context,widget: AddServiceClinic());
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
                    'Services',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: ScreenUtil().setSp(24)),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(15)),
              services.length == 0
                  ? Center(
                child: Text('No Services Found '),
              )
                  : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 15.0),
                    elevation: 4,
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
                            return ClinicServiceDetail(services[index],index);
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    Reaaia_Icons.service_icon,
                                    color: ColorsUtils.blueColor,
                                  ),
                                  height: 35.0,
                                  width: 35.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      services[index].serviceName,
                                      style: TextStyle(
                                          color: ColorsUtils.blueColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(15)),
                                    ),
                                    SizedBox(height: 5.0,),
                                    Text(
                                      services[index].serviceDiscount+' % OFF',
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
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:  '2000',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(17)),
                                      ),
                                      TextSpan(
                                        text:  ' EGP',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(11)),
                                      )
                                    ],
                                  )
                                ),
                                SizedBox(height: 5.0,),
                                Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:  services[index].serviceCost,

                                          style: TextStyle(
                                              color: ColorsUtils.textGrey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenUtil().setSp(13),
                                              decoration: TextDecoration.lineThrough),
                                        ),
                                        TextSpan(
                                          text:  ' EGP',
                                          style: TextStyle(
                                              color: ColorsUtils.onBoardingTextGrey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenUtil().setSp(10),
                                              decoration: TextDecoration.lineThrough),
                                        )
                                      ],
                                    )
                                ),
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
