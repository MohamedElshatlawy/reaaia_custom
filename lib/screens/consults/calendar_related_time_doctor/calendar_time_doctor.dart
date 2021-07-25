import 'package:flutter/material.dart';
import 'package:reaaia/helpers/utils.dart';
import 'package:reaaia/screens/consults/detail_status_consult_related_doctor_work/detail_status_consult_doctor_work_library.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';
import 'package:reaaia/views/widgets/text_style_widget.dart';
import 'package:table_calendar/table_calendar.dart';


import '../../customFunctions.dart';

class CalendarRelatedTimeDoctor extends StatefulWidget {
  @override
  _CalendarRelatedTimeDoctorState createState() =>
      _CalendarRelatedTimeDoctorState();
}

class _CalendarRelatedTimeDoctorState extends State<CalendarRelatedTimeDoctor> {
  ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  DateTime _rangeStart;
  DateTime _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime start, DateTime end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ignore: missing_required_param
        TableCalendar<Event>(

          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          // rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          // calendarFormat: _calendarFormat,
          rangeSelectionMode: _rangeSelectionMode,
           eventLoader: _getEventsForDay,
          // startingDayOfWeek: StartingDayOfWeek.saturday,
          calendarStyle: CalendarStyle(
            // Use `CalendarStyle` to customize the UI
            outsideDaysVisible: true,
          ),
          onDaySelected: _onDaySelected,
          onRangeSelected: _onRangeSelected,
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        const SizedBox(height: 8.0),
        ValueListenableBuilder<List<Event>>(
          valueListenable: _selectedEvents,
          builder: (context, value, _) {
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0),
                 showTypeConsultsWidget('Still in Progress'),
                  _showListConsultsRealtedSpesficDoctorWork(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Padding showTypeConsultsWidget(String statusConsult) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 5.0, bottom: 7.0, top: 7.0),
      child: Text(
        AppLocalizations.of(context).translate(
          statusConsult,
        ),
        style: TextStyleWidget.build(
          color: Color(0xff1e1f20),
          fontSize: 18.0,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Expanded _showListConsultsRealtedSpesficDoctorWork() {
    return Expanded(
      child: ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 5.0, left: 5.0),
              child: InkWell(
                onTap: () {
                  CustomFunctions.pushScreenRepcalement(
                      widget: DetailStatusConsultsSelectedRealtedDoctorWork(
                          AppLocalizations.of(context).translate('')),
                      context: context);
                },
                child: Card(
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
                                  icon:
                                      Image.asset('assets/images/exchange.png'),
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
          }),
    );
  }
}
