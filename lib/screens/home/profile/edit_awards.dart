import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/model/data/signup/awards_model.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/home/profile/add_award.dart';
import 'package:reaaia/screens/home/profile/custom_view_image.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/screens/widgets/custom_textfield.dart';
import 'package:reaaia/utils/ColorsUtils.dart';

class EditAwardsPage extends StatefulWidget {
  @override
  _EditAwardsPageState createState() => _EditAwardsPageState();
}

class _EditAwardsPageState extends State<EditAwardsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Awards> _awards = [];

  @override
  void initState() {
    super.initState();
    _awards.add(Awards());
    _awards.add(Awards());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.greyColor,
      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: Container(
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
                        onTap: () async {
                          await showModalBottomSheet(
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
                              return AddAwardPage();
                            },
                          );
                          // setState(() {
                          // Provider.of<ClinicsProvider>(context, listen: false)
                          //     .getBranchesData(widget.clinicId);
                          // });
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
                        'Edit Awards',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil().setSp(24)),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: _awards.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        width: ScreenUtil().screenWidth,
                        //height: ScreenUtil().setHeight(250),
                        padding: EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: ScreenUtil().setHeight(16)),
                            CustomTextField(
                              filledColor: Colors.white,
                              lablel: ' Award Name ',
                              hasBorder: true,
                              onSaved: (val) {
                                _awards[index].name = val;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field Required';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                _awards[index].name = val;
                              },
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            CustomTextField(
                              filledColor: Colors.white,
                              lablel: ' Year',
                              hasBorder: true,
                              onSaved: (val) {
                                _awards[index].year = val;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field Required';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                _awards[index].year = val;
                              },
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),
                            InkWell(
                              child: Text(
                                'View Award',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: ColorsUtils.blueColor,
                                ),
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(24),
                                    topLeft: Radius.circular(24),
                                  )),
                                  barrierColor:
                                      ColorsUtils.modalSheetBarrierColor,
                                  backgroundColor:
                                      ColorsUtils.modalSheetBarrierColor,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return CustomViewImage(
                                      image: 'assets/default-avatar.png',
                                      btnRemoveName: 'Remove Award',
                                      btnChangeName: 'Change Award',
                                      onChange: () {},
                                      onRemove: () {},
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),
                            Container(
                              height: ScreenUtil().setHeight(40),
                              child: CustomRoundedButton(
                                iconLeft: true,
                                backgroundColor: Colors.red.withOpacity(0.1),
                                borderColor: Colors.red,
                                text: 'Remove Award ',
                                pressed: () {
                                  setState(() {
                                    _awards.removeAt(index);
                                  });
                                },
                                textColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
