import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/utils/ColorsUtils.dart';

class CustomProfileContainer extends StatelessWidget {
  final String imageName;
  final String docName;
  final String email;
 final String address;


  CustomProfileContainer({
    @required this.imageName,
    @required this.docName,
    @required this.email,
    @required this.address,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                //padding: EdgeInsets.all(5.0),
                width: ScreenUtil().screenWidth * 0.2,
                decoration:  BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius:BorderRadius.circular(25),
                  child: Image.asset(
                    imageName,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 16,
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Container(
            width: ScreenUtil().screenWidth * 0.55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  docName,
                  style: TextStyle(
                      color: ColorsUtils.blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(15)),
                ),
                Text(
                  email,
                  style: TextStyle(
                      color: ColorsUtils.onBoardingTextGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(13)),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: ColorsUtils.blueColor,
                      size: 22,
                    ),
                    Flexible(
                      child: Text(
                        ' '+address,
                        style: TextStyle(
                            color: ColorsUtils.textGrey,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(13)),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
