import 'package:flutter/material.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';
import 'package:reaaia/views/widgets/text_style_widget.dart';

import '../customFunctions.dart';
import 'detail_status_consult_related_doctor_work/detail_status_consult_doctor_work_library.dart';

class StatusDoctorRealtedTypeConsults extends StatefulWidget {
  String statusConsults = '';
  int numberOfConsults = 0;
  final typeConsults;
  StatusDoctorRealtedTypeConsults(this.statusConsults, this.typeConsults,
      {Key key, this.numberOfConsults})
      : super(key: key);

  @override
  _StatusDoctorRealtedTypeConsultsState createState() =>
      _StatusDoctorRealtedTypeConsultsState();
}

class _StatusDoctorRealtedTypeConsultsState
    extends State<StatusDoctorRealtedTypeConsults> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0),
                    //this will be chanage when comming data from backend then pass value by index
                    showTypeConsultsWidget(AppLocalizations.of(context).translate(widget.typeConsults)),
                    _showListConsultsRealtedSpesficDoctorWork(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView _showListConsultsRealtedSpesficDoctorWork() {
    return ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 5.0, left: 5.0),
            child: InkWell(
              onTap: () {
                CustomFunctions.pushScreenRepcalement(
                    widget: DetailStatusConsultsSelectedRealtedDoctorWork(widget.typeConsults),
                    context: context);
              },
              child: 
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              'https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/256x256/plain/user.png',
                              height: 65.0,
                              width: 65.0,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 35,
                          left: 40,
                          child: IconButton(
                              onPressed: () {}, icon: Icon(Icons.cabin)),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'John Ray . ',
                                style: TextStyleWidget.build(
                                  color: Color(0xff5a5a68),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Reserved',
                                style: TextStyleWidget.build(
                                  color: Color(0xff00d65b),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            'John Ray',
                            style: TextStyleWidget.build(
                              color: Color(0xff5a5a68),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            'Today 14:00 - 14:30',
                            style: TextStyleWidget.build(
                              color: Color(0xff9393aa),
                              fontSize: 11.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            child: Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: Image.asset('assets/images/exchange.png'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            child: IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                  'assets/images/Icons-24pt-ic_exp.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Padding showTypeConsultsWidget(String statusConsult) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 5.0, bottom: 7.0, top: 7.0),
      child: Text(
        widget.numberOfConsults == 0
            ? statusConsult
            : '$statusConsult[${widget.numberOfConsults}]',
        style: TextStyleWidget.build(
          color: Color(0xff1e1f20),
          fontSize: 18.0,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
