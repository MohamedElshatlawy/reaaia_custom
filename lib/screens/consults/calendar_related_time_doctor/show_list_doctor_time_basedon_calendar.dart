import 'package:flutter/material.dart';
import 'package:reaaia/screens/consults/detail_status_consult_related_doctor_work/detail_status_consult_doctor_work_library.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';
import '../../customFunctions.dart';
import 'calendar_time_doctor.dart';

class ShowListTimesDoctorRelatedCalendar extends StatefulWidget {
  ShowListTimesDoctorRelatedCalendar({Key key}) : super(key: key);

  @override
  _ShowListTimesDoctorRelatedCalendarState createState() =>
      _ShowListTimesDoctorRelatedCalendarState();
}

class _ShowListTimesDoctorRelatedCalendarState
    extends State<ShowListTimesDoctorRelatedCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
       leading: IconButton(
          onPressed: () {
            CustomFunctions.pushScreenRepcalement(
                widget: DetailStatusConsultsSelectedRealtedDoctorWork(AppLocalizations.of(context).translate('All')), context: context);
          },
          icon: Image.asset('assets/images/BackArrow.png'),
        ),
      ),
      body: CalendarRelatedTimeDoctor(),
    );
  }
}
