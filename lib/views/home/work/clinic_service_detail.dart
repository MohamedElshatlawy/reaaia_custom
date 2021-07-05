import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/data/clinicsModel/service_model.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';
import 'package:reaaia/views/customFunctions.dart';
import 'package:reaaia/views/home/work/edit_service_clinic.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';

class ClinicServiceDetail extends StatefulWidget {
  final ServiceModel serviceModel;
  final int index;

  ClinicServiceDetail(this.serviceModel, this.index);

  @override
  _ClinicServiceDetailState createState() => _ClinicServiceDetailState();
}

class _ClinicServiceDetailState extends State<ClinicServiceDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.82,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenUtil().setHeight(20)),
              CustomText(
                name: 'Service Name',
                decs: widget.serviceModel.serviceName,
              ),
              CustomText(
                name: 'Service Description',
                decs: widget.serviceModel.serviceDesc,
              ),
              CustomText(
                name: 'Service Requirements',
                decs: widget.serviceModel.serviceRequirements,
              ),
              CustomText(
                name: 'Service Cost',
                decs: widget.serviceModel.serviceCost + ' EGP',
              ),
              CustomText(
                name: 'DisCount %',
                decs: widget.serviceModel.serviceDiscount + ' %',
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 100,
                  //width: MediaQuery.of(context).size.width*0.8,
                  child: ListView.builder(
                    padding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 5.0),
                    //shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.serviceModel.images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: 86.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              widget.serviceModel.images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
                child: Divider(
                  color: ColorsUtils.lineColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 50.0,
                      child: CustomRoundedButton(
                        backgroundColor: Colors.white,
                        borderColor: ColorsUtils.primaryGreen,
                        text: 'Delete',
                        pressed: () {
                          Provider.of<ClinicsProvider>(context, listen: false)
                              .deleteServiceClinic(widget.index);
                          CustomFunctions.popScreen(context);
                        },
                        textColor: ColorsUtils.primaryGreen,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      height: 50.0,
                      child: CustomRoundedButton(
                        backgroundColor: ColorsUtils.primaryGreen,
                        borderColor: ColorsUtils.primaryGreen,
                        text: 'Edit Service',
                        pressed: ()  {
                          CustomFunctions.pushScreen(context: context,widget: EditServiceClinic(serviceModel: widget.serviceModel, index: widget.index));

                        },
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String name;
  final String decs;

  CustomText({this.name, this.decs});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: ScreenUtil().setSp(17)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            decs,
            style: TextStyle(
                color: ColorsUtils.onBoardingTextGrey,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(16)),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
          child: Divider(
            color: ColorsUtils.lineColor,
          ),
        ),
      ],
    );
  }
}
