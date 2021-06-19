import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/views/widgets/custom_rounded_btn.dart';

import '../../customFunctions.dart';
import 'complete_req1_map.dart';

class CompleteRegister1 extends StatefulWidget {
  @override
  _CompleteRegister1State createState() => _CompleteRegister1State();
}

class _CompleteRegister1State extends State<CompleteRegister1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Container(
        //  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().setHeight(48)),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      CustomFunctions.popScreen(context);
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(24)),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]),
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Image.asset(
                'assets/complete_info1.png',
                scale: 1.5,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(53),
              ),
              Container(
                height: ScreenUtil().setHeight(50),
                width: 236,
                child: CustomRoundedButton(
                  backgroundColor: ColorsUtils.primaryGreen,
                  borderColor: ColorsUtils.primaryGreen,
                  text: 'Next',
                  pressed: () {
                    CustomFunctions.pushScreen(
                        context: context, widget: CompleteRequest1Map());
                  },
                  textColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
