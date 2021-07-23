import 'package:flutter/material.dart';
import 'package:reaaia/screens/consults/status_doctor_realted_type_consult.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';
import 'package:reaaia/views/widgets/text_style_widget.dart';

import '../customFunctions.dart';
import 'calendar_related_time_doctor/show_list_doctor_time_basedon_calendar.dart';

class ConsultsDoctor extends StatefulWidget {
  String typeConsults = "Consults for Today";

  int numberDoctors = 0;
  ConsultsDoctor(this.typeConsults, {Key key, this.numberDoctors})
      : super(key: key);

  @override
  _ConsultsDoctorState createState() => _ConsultsDoctorState();
}

class _ConsultsDoctorState extends State<ConsultsDoctor> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(155),
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              right: 0,
              left: 0,
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              flexibleSpace: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBarWidget(context),
                  showTypeConsultsWidget(),
                  new SizedBox(
                    height: 10,
                  ),
                  widget.numberDoctors == 0
                      ? Container()
                      : Container(
                          child: TabBar(
                            labelColor: Colors.white,
                            unselectedLabelColor:
                                ColorsUtils.unSelectTabBarColor,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff41cbcb),
                            ),
                            tabs: [
                              nameTopicTabbarWidget('All'),
                              nameTopicTabbarWidget('Online'),
                              nameTopicTabbarWidget('Clinic'),
                              nameTopicTabbarWidget('Home'),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
        body: widget.numberDoctors == 0
            ? Center(
                child: Text(AppLocalizations.of(context)
                    .translate('No upcoming consults')))
            : _showTabBarView(),
      ),
    );
  }

  TabBarView _showTabBarView() {
    return TabBarView(
      children: [
        StatusDoctorRealtedTypeConsults(
          AppLocalizations.of(context).translate('Still in Progress'),
          'All',
          numberOfConsults: 0,
        ),
        StatusDoctorRealtedTypeConsults(
            AppLocalizations.of(context).translate('Next Consults'), 
            'Online',
            numberOfConsults: 4),
        StatusDoctorRealtedTypeConsults(
            AppLocalizations.of(context).translate('Upcoming Consult'),
            'Clinic',
            numberOfConsults: 5),
        StatusDoctorRealtedTypeConsults(
            AppLocalizations.of(context).translate('Today Consults'),
             'Home',
            numberOfConsults: 4),
      ],
    );
  }

  Padding showTypeConsultsWidget() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 5.0, bottom: 5.0, top: 7.0),
      child: Text(
        AppLocalizations.of(context).translate(widget.typeConsults),
        style: TextStyleWidget.build(
          color: Color(0xff1e1f20),
          fontSize: 18.0,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Padding appBarWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: IconButton(
                icon: Image.asset('assets/images/BackArrow.png'),
                onPressed: _backToPreviousScreen,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.58,
            ),
            Navigator.of(context).canPop()
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Color(0xff00173d),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: Image.asset('assets/images/search.png'),
                      onPressed: _openSearch,
                    ),
                  ),
            Navigator.of(context).canPop()
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Color(0xff00173d),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: Image.asset('assets/images/calendar.png'),
                      onPressed: _openCalander,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  _openCalander() {
      CustomFunctions.pushScreenRepcalement(
              widget: ShowListTimesDoctorRelatedCalendar(), context: context);
    
  }
  _openSearch() {}
  _backToPreviousScreen() {}

  Tab nameTopicTabbarWidget(String titleTabBar, {int numberDoctors}) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: ColorsUtils.transparentColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context).translate(titleTabBar),
          ),
        ),
      ),
    );
  }
}
