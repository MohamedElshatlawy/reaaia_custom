import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/model/clinics/service_model.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/home/work/edit_service_clinic.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/workProvider/clinics_provider.dart';

class ClinicServiceDetail extends StatefulWidget {
  final ServiceData serviceModel;
  final int index;
  final int clinicID;

  ClinicServiceDetail(this.serviceModel, this.index,this.clinicID);

  @override
  _ClinicServiceDetailState createState() => _ClinicServiceDetailState();
}

class _ClinicServiceDetailState extends State<ClinicServiceDetail> {
  @override
  Widget build(BuildContext context) {
    print(widget.index);

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
                decs: widget.serviceModel.name,
              ),
              CustomText(
                name: 'Service Description',
                decs: widget.serviceModel.description,
              ),
              CustomText(
                name: 'Service Requirements',
                decs: widget.serviceModel.requirements,
              ),
              CustomText(
                name: 'Service Cost',
                decs: widget.serviceModel.price + ' EGP',
              ),
              CustomText(
                name: 'DisCount %',
                decs: widget.serviceModel.discountPercentage.toString() + ' %',
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
                            child: Image.network(
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
                        pressed: () async{
                        await  Provider.of<ClinicsProvider>(context, listen: false)
                              .deleteService(widget.serviceModel.id,widget.index);
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
                          CustomFunctions.pushScreen(context: context,widget: EditServiceClinic(serviceModel: widget.serviceModel, index: widget.index,clinicID: widget.clinicID,));

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
