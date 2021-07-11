import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/utils/ColorsUtils.dart';

class CustomContainerView extends StatelessWidget {
  final String imageName;
  final String docName;
  final String address;
  final double rate;
  final int numOfReviews;
  final bool hasIcon;
  final bool hasBorder;
  final Color iconColor;

  CustomContainerView({
    @required this.imageName,
    @required this.docName,
    @required this.address,
    @required this.rate,
    @required this.numOfReviews,
    @required this.hasIcon,
    @required this.hasBorder,
    this.iconColor,
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
                padding: EdgeInsets.all(5.0),
                width: ScreenUtil().screenWidth * 0.2,
                decoration: hasBorder
                    ? BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        borderRadius: BorderRadius.circular(25),
                      )
                    : null,
                child: Image.asset(
                  imageName,
                  fit: BoxFit.cover,
                ),
              ),
              if (hasIcon)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.circle,
                    color: iconColor,
                    size: 14,
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Container(
            width: ScreenUtil().screenWidth * 0.53,
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
                  address,
                  style: TextStyle(
                      color: ColorsUtils.onBoardingTextGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(12)),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.star,
                      color: ColorsUtils.starColor,
                      size: 22,
                    ),
                    Text(
                      ' '+rate.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenUtil().setSp(13)),
                    ),
                    Text(
                      '  ($numOfReviews reviews)',
                      style: TextStyle(
                          color: ColorsUtils.copyRightsColor,
                          fontSize: ScreenUtil().setSp(13)),
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
