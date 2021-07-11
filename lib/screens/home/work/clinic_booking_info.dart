import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';
import 'package:reaaia/utils/ColorsUtils.dart';


class ClinicBookingInfoPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenUtil().setHeight(48)),
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
                SizedBox(height: ScreenUtil().setHeight(17)),
                Row(
                  children: [
                    Text(
                      'Booking Info',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(24)),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(35)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: 'Average Waiting Time (Min.)',
                  hasBorder: true,
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This Field Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(17)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: 'Clinic Fees (egp)',
                  hasBorder: true,
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This Field Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(17)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: 'Follow-up Fees (egp)',
                  hasBorder: true,
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This Field Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(17)),
                CustomTextField(
                  filledColor: Colors.white,
                  lablel: 'Follow-up allowance (Day)',
                  hasBorder: true,
                  onSaved: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This Field Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(7)),
                Text(
                  'Duration after that follow-up expired. Patient couldn`t reserve it and will have to set a new appointment.',
                  style: TextStyle(
                    color: ColorsUtils.onBoardingTextGrey,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(15)),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: ScreenUtil().setHeight(50),
                    width: 236,
                    child: CustomRoundedButton(
                      backgroundColor: ColorsUtils.primaryGreen,
                      borderColor: ColorsUtils.primaryGreen,
                      text: 'Save',
                      pressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          CustomFunctions.popScreen(context);

                        }
                      },
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
