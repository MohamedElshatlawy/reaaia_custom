import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/utils/ColorsUtils.dart';

class CustomCardView extends StatelessWidget {
  final String namePic;
  final String nameText;
  final Function onPressed;

  CustomCardView({@required this.namePic,@required this.nameText,@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          ),
        child: Container(
          //height: 155.0,
          width: 155.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),),
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(namePic,fit: BoxFit.cover,),
              SizedBox(height: 15.0,),
              Text(
                nameText,
                style: TextStyle(
                    color: ColorsUtils.textGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil().setSp(13)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
