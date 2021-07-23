import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:reaaia/screens/widgets/custom_badge_widget.dart';
import 'package:reaaia/screens/widgets/custom_card_widget.dart';
import 'package:reaaia/screens/widgets/custom_textfield_widget.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/utils/reaaia_icons.dart';

class ReaaiaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().setHeight(48)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(40),
                        height: ScreenUtil().setHeight(40),
                        //padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]),
                            borderRadius: BorderRadius.circular(5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: false
                              ? Image.network(
                                  '',
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/default-avatar.png',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi Dr,',
                            style: TextStyle(
                                color: ColorsUtils.textGrey,
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenUtil().setSp(17)),
                          ),
                          Text(
                            'How’re you today?',
                            style: TextStyle(
                                color: ColorsUtils.onBoardingTextGrey,
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenUtil().setSp(14)),
                          ),
                        ],
                      )
                    ],
                  ),
                  CustomBadgeWidget(
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      padding: EdgeInsets.all(2.0),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            ReaaiaIcons.notification_icon,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    value: 55,
                    color: Colors.red,
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(25)),
              CustomTextField(
                filledColor: Colors.white,
                hintText: 'Search patient, health issue, ...',
                icon: Icon(ReaaiaIcons.search_icon),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Consults for today ',
                        style: TextStyle(
                            color: ColorsUtils.textGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: ScreenUtil().setSp(24)),
                      ),
                      Text(
                        '5 of 9 completed ',
                        style: TextStyle(
                            color: ColorsUtils.onBoardingTextGrey,
                            fontSize: ScreenUtil().setSp(13)),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 6.0,
                      percent: 0.4,
                      center: Text(
                        '4',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: ColorsUtils.primaryGreen,
                            fontWeight: FontWeight.w700,
                            fontSize: ScreenUtil().setSp(24)),
                      ),
                      progressColor: ColorsUtils.primaryGreen,
                    ),
                  )
                ],
              ),
              //SizedBox(height: ScreenUtil().setHeight(15)),
              GridView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.05,
                    crossAxisCount: 2,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 7),
                children: [
                  CustomCardView(
                    namePic: 'assets/images/img_schedule.png',
                    nameText: 'Schedule',
                    onPressed: () {},
                  ),
                  CustomCardView(
                    namePic: 'assets/images/img_consult_history.png',
                    nameText: 'Consult History',
                    onPressed: () {},
                  ),
                  CustomCardView(
                    namePic: 'assets/images/img_patient_management.png',
                    nameText: 'Patient Management',
                    onPressed: () {},
                  ),
                  CustomCardView(
                    namePic: 'assets/images/img_free_question.png',
                    nameText: 'Free Consults',
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
