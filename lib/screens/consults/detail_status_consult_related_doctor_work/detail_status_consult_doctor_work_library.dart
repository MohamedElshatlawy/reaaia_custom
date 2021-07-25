import 'package:flutter/material.dart';
import 'package:reaaia/viewModels/locale/appLocalization.dart';
import '../../../views/widgets/flat_button_widget.dart';
import '../../../views/widgets/scroll_view_widget.dart';
import '../../../views/widgets/text_style_widget.dart';
import '../doctors_work_library_consult.dart';
import '../../customFunctions.dart';

// ignore: must_be_immutable
class DetailStatusConsultsSelectedRealtedDoctorWork extends StatefulWidget {
  String typeConsults;
  DetailStatusConsultsSelectedRealtedDoctorWork(this.typeConsults, {Key key})
      : super(key: key);

  @override
  _DetailStatusConsultsSelectedRealtedDoctorWorkState createState() =>
      _DetailStatusConsultsSelectedRealtedDoctorWorkState();
}

class _DetailStatusConsultsSelectedRealtedDoctorWorkState
    extends State<DetailStatusConsultsSelectedRealtedDoctorWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              AppLocalizations.of(context).translate(widget.typeConsults),
              style: TextStyleWidget.build(
                  color: Color(0xff5a5a68),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              AppLocalizations.of(context).translate('status'),
              style: TextStyleWidget.build(
                color: Color(0xff00d65b),
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            CustomFunctions.pushScreenRepcalement(
                widget: ConsultsDoctor("Consults for Today"), context: context);
          },
          icon: Image.asset('assets/images/BackArrow.png'),
        ),
      ),
      body: ScrollViewWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.0,
            ),
            _showPersonalDetailDoctor(),
            _showRequestTime(),
            _showConsultsDetails(),
            _showAditionialInformationsRelatedDoctor(),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                AppLocalizations.of(context).translate('cancel Appointment'),
                style: TextStyleWidget.build(
                    color: Color(0xff9393aa),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline),
                // style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
            _showFootorBasedOnStatusConsults(),
          ],
        ),
      ),
    );
  }

  Padding _showPersonalDetailDoctor() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                    child:
                        IconButton(onPressed: () {}, icon: Icon(Icons.cabin)),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 15.0, top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text(
                        'Christine Bradley',
                        style: TextStyleWidget.build(
                          color: Color(0xff5a5a68),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).translate('Female'),
                            style: TextStyleWidget.build(
                              color: Color(0xff9393aa),
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .translate('30 Years old'),
                            style: TextStyleWidget.build(
                              color: Color(0xff9393aa),
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Container(
                          width: 30,
                          child: IconButton(
                            iconSize: 20,
                            color: Colors.red,
                            onPressed: () {},
                            icon: Icon(
                              Icons.call,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          AppLocalizations.of(context)
                              .translate('968-926-0227'),
                          style: TextStyleWidget.build(
                            color: Color(0xff5a5a68),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _showRequestTime() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      child: IconButton(
                        iconSize: 20,
                        color: Colors.green,
                        onPressed: () {},
                        icon: Icon(
                          Icons.calendar_today,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      AppLocalizations.of(context).translate("Request Time"),
                      style: TextStyleWidget.build(
                        color: Color(0xff5a5a68),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)
                        .translate("Today, Jan 5, 2020"),
                    style: TextStyleWidget.build(
                      color: Color(0xff5a5a68),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    AppLocalizations.of(context).translate("14:00 - 14:30"),
                    style: TextStyleWidget.build(
                      color: Color(0xff9393aa),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _showConsultsDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      child: IconButton(
                        iconSize: 20,
                        color: Colors.green,
                        onPressed: () {},
                        icon: Icon(
                          Icons.contact_support,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate('Consults Details'),
                      style: TextStyleWidget.build(
                        color: Color(0xff5a5a68),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('For his daughter, 4 years old'),
                    style: TextStyleWidget.build(
                      color: Color(0xff5a5a68),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    AppLocalizations.of(context).translate(
                        'I think my child has been exposed to chickenpox, what should I do? How long does it take to show signs of chickenpoxafter being exposed?'),
                    style: TextStyleWidget.build(
                      color: Color(0xff9393aa),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          'https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/256x256/plain/user.png',
                          height: 120.0,
                          width: 65.0,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('Redness on the back of the neck'),
                            style: TextStyleWidget.build(
                              color: Color(0xff5a5a68),
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('updated jan 20, 2021'),
                            style: TextStyleWidget.build(
                              color: Color(0xff9393aa),
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _showAditionialInformationsRelatedDoctor() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      child: IconButton(
                        iconSize: 20,
                        color: Colors.green,
                        onPressed: () {},
                        icon: Icon(
                          Icons.info_rounded,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate('Additional Information'),
                      style: TextStyleWidget.build(
                        color: Color(0xff5a5a68),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('Diagnosed condition'),
                    style: TextStyleWidget.build(
                      color: Color(0xff5a5a68),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    AppLocalizations.of(context).translate('Chickenpox'),
                    style: TextStyleWidget.build(
                      color: Color(0xff9393aa),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context).translate('Medications'),
                    style: TextStyleWidget.build(
                      color: Color(0xff5a5a68),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    AppLocalizations.of(context).translate('None'),
                    style: TextStyleWidget.build(
                      color: Color(0xff9393aa),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context).translate('Allergies'),
                    style: TextStyleWidget.build(
                      color: Color(0xff5a5a68),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    AppLocalizations.of(context).translate('None'),
                    style: TextStyleWidget.build(
                      color: Color(0xff9393aa),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _showFootorBasedOnStatusConsults() {
    // this change based on type consults reserved or check in and so in
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.99,
        height: 65.0,
        child: FlatButtonWidget(
            icon: Image.asset('assets/images/Icons-24pt-ic_exp.png',
                color: Colors.white),
            // Icon(Icons.add_box_rounded, color: Colors.white,),
            text: 'Add Counter',
            onPressed: () {}),
      ),
    );
    /*
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.99,
          height: 65.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: FlatButtonWidget(
                    icon: Image.asset(
                      'assets/images/exchange.png',
                      color: Color(0xff3dc4c4),
                    ),
                    color: Colors.white,
                    // Icon(Icons.add_box_rounded, color: Colors.white,),
                    text: 'Change Date',
                    onPressed: () {}),
              ),
              Card(
                child: FlatButtonWidget(
                    icon: Icon(
                      Icons.add_box_rounded,
                      color: Colors.white,
                    ),
                    text: 'Start in [10 min]',
                    color: Colors.white,
                    onPressed: () {}),
              ),
            ],
          )
    );
    */
  }
}
