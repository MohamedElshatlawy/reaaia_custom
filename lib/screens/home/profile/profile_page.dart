import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reaaia/screens/customFunctions.dart';
import 'package:reaaia/screens/home/profile/custom_profile_container.dart';
import 'package:reaaia/screens/home/profile/edit_certificates.dart';
import 'package:reaaia/screens/home/profile/edit_education.dart';
import 'package:reaaia/screens/home/profile/edit_languages.dart';
import 'package:reaaia/screens/home/profile/edit_profile.dart';
import 'package:reaaia/screens/widgets/custom_rounded_btn.dart';
import 'package:reaaia/utils/ColorsUtils.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  List<String> _listTest=['',''];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: ScreenUtil().screenHeight * 0.28,
              color: ColorsUtils.darkGreenColor,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  SizedBox(height: ScreenUtil().setHeight(60)),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: ScreenUtil().setHeight(15)),
                        CustomProfileContainer(
                          imageName: 'assets/default-avatar.png',
                          docName: 'Dr. Mohamed Gaawan',
                          email: '@mohamedgaawan',
                          address: '150 Greene St, New York, ...',
                        ),
                        Divider(
                          color: ColorsUtils.onBoardingTextGrey,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: CustomRoundedButton(
                            height: 50.0,
                            iconLeft: true,
                            backgroundColor: ColorsUtils.primaryGreen,
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            text: 'Edit Profile ',
                            pressed: () {
                              CustomFunctions.pushScreen(context: context,widget: EditProfilePage());
                            },
                            textColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ScreenUtil().setHeight(12)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListTile(
                            leading: Container(
                                width: 35,
                                height: 35,
                                //margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: ColorsUtils.primaryGreen
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(
                                  Icons.add,
                                  color: ColorsUtils.primaryGreen,
                                )),
                            title: Text(
                              'Education',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsUtils.textGrey),
                            ),
                            trailing: InkWell(
                              onTap: (){
                                CustomFunctions.pushScreen(context: context,widget: EditEducationPage());
                              },
                              child: Container(
                                  width: 35,
                                  height: 35,
                                  //margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color:
                                          ColorsUtils.blueColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Icon(
                                    Icons.edit,
                                    color: ColorsUtils.blueColor,
                                  ),),
                            ),
                          ),
                        ),
                        Divider(
                          color: ColorsUtils.onBoardingTextGrey,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextView(
                                name: 'Scientific Degree',
                                desc: 'Consultant',
                              ),
                              CustomTextView(
                                name: 'Specialty',
                                desc: 'Allergy & Immunology',
                              ),
                              CustomTextView(
                                name: 'SubSpecialty',
                                desc:
                                    'Adult Internal Medicine \n Adult Allergy / Immunology ',
                              ),
                              CustomTextView(
                                name: 'Graduation University',
                                desc: 'Alexandria University',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Professional Practice Licence',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsUtils.onBoardingTextGrey,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  'View Licence',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    color: ColorsUtils.blueColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ScreenUtil().setHeight(12)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListTile(
                            leading: Container(
                                width: 35,
                                height: 35,
                                //margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: ColorsUtils.primaryGreen
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(
                                  Icons.translate,
                                  color: ColorsUtils.primaryGreen,
                                )),
                            title: Text(
                              'Languages',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsUtils.textGrey),
                            ),
                            trailing: InkWell(
                              onTap: (){
                                CustomFunctions.pushScreen(context: context,widget: EditLanguagesPage());
                              },
                              child: Container(
                                  width: 35,
                                  height: 35,
                                  //margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color:
                                          ColorsUtils.blueColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Icon(
                                    Icons.edit,
                                    color: ColorsUtils.blueColor,
                                  )),
                            ),
                          ),
                        ),
                        Divider(
                          color: ColorsUtils.onBoardingTextGrey,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 0.0),
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _listTest.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'English',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                            color: ColorsUtils.blueColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '(Level 1)',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: ColorsUtils.onBoardingTextGrey,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                 if (index!=_listTest.length-1)
                                  Divider(
                                    color: ColorsUtils.onBoardingTextGrey,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ScreenUtil().setHeight(12)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListTile(
                            leading: Container(
                                width: 35,
                                height: 35,
                                //margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: ColorsUtils.primaryGreen
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(
                                  Icons.clear,
                                  color: ColorsUtils.primaryGreen,
                                )),
                            title: Text(
                              'Certifications',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsUtils.textGrey),
                            ),
                            trailing: InkWell(
                              onTap: (){
                                CustomFunctions.pushScreen(context: context,widget: EditCertificatesPage());
                              },
                              child: Container(
                                  width: 35,
                                  height: 35,
                                  //margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color:
                                      ColorsUtils.blueColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Icon(
                                    Icons.edit,
                                    color: ColorsUtils.blueColor,
                                  )),
                            ),
                          ),
                        ),
                        Divider(
                          color: ColorsUtils.onBoardingTextGrey,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 0.0),
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _listTest.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Honor Certificate',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                                color: ColorsUtils.blueColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              '(2002)',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: ColorsUtils.onBoardingTextGrey,
                                              ),
                                            ),

                                          ],
                                        ),
                                        InkWell(
                                          child: Text(
                                            'View',
                                            style: TextStyle(
                                              decoration: TextDecoration.underline,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              color: ColorsUtils.blueColor,
                                            ),
                                          ),
                                          onTap: (){},
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  if (index!=_listTest.length-1)
                                    Divider(
                                      color: ColorsUtils.onBoardingTextGrey,
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ScreenUtil().setHeight(12)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListTile(
                            leading: Container(
                                width: 35,
                                height: 35,
                                //margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: ColorsUtils.primaryGreen
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(
                                  Icons.clear,
                                  color: ColorsUtils.primaryGreen,
                                )),
                            title: Text(
                              'Awards',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsUtils.textGrey),
                            ),
                            trailing: Container(
                                width: 35,
                                height: 35,
                                //margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color:
                                    ColorsUtils.blueColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(
                                  Icons.edit,
                                  color: ColorsUtils.blueColor,
                                )),
                          ),
                        ),
                        Divider(
                          color: ColorsUtils.onBoardingTextGrey,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 0.0),
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _listTest.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Honor Certificate',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                                color: ColorsUtils.blueColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              '(2002)',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: ColorsUtils.onBoardingTextGrey,
                                              ),
                                            ),

                                          ],
                                        ),
                                        InkWell(
                                          child: Text(
                                            'View',
                                            style: TextStyle(
                                              decoration: TextDecoration.underline,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              color: ColorsUtils.blueColor,
                                            ),
                                          ),
                                          onTap: (){},
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  if (index!=_listTest.length-1)
                                    Divider(
                                      color: ColorsUtils.onBoardingTextGrey,
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextView extends StatelessWidget {
  final String name;
  final String desc;

  CustomTextView({this.name, this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenUtil().setHeight(10)),
          Text(
            name,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: ColorsUtils.onBoardingTextGrey,
            ),
          ),
          Text(
            desc,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: ColorsUtils.blueColor,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(15)),
          Divider(
            color: ColorsUtils.onBoardingTextGrey,
          ),
        ],
      ),
    );
  }
}
