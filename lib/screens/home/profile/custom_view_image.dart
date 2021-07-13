import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/utils/ColorsUtils.dart';

class CustomViewImage extends StatelessWidget {
  final String btnRemoveName;
  final Function onRemove;
  final String btnChangeName;
  final Function onChange;
  final String image;

  CustomViewImage({
    @required this.btnRemoveName,
    @required this.onRemove,
    @required this.btnChangeName,
    @required this.onChange,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: ScreenUtil().screenWidth,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24.0),
              topLeft: Radius.circular(24.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  CustomFunctions.popScreen(context);
                },
                child: Container(
                    //margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        //border: Border.all(color: Colors.grey[300],),
                        color: ColorsUtils.copyRightsColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.clear,
                      color: ColorsUtils.textGrey,
                      size: 22,
                    )),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                height: 375,
                width: double.infinity,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(40)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CustomRoundedButton(
                        height: 50.0,
                        backgroundColor: Colors.white,
                        borderColor: Colors.red.withOpacity(0.4),
                        text: btnRemoveName,
                        pressed: onRemove,
                        textColor: Colors.red,
                        fontSize: 13.0,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: CustomRoundedButton(
                        height: 50.0,
                        backgroundColor: ColorsUtils.primaryGreen,
                        borderColor: ColorsUtils.primaryGreen,
                        text: btnChangeName,
                        pressed: onChange,
                        textColor: Colors.white,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
            ],
          ),
        ),
      ),
    );
  }
}
