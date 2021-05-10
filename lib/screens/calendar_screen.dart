import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hackathons_lk_app/screens/event_inner_screen.dart';
import 'package:hackathons_lk_app/services/customicons_icons.dart';
import 'package:hackathons_lk_app/services/api_data.dart';
import 'package:hackathons_lk_app/services/scroll_glow_disabler.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();
  List _selectedEvents = [];
  Future<List<Data>> eventData;
  Map<DateTime, List> formattedEventData = {};

  //* fetch data from API
  Future<List<Data>> fetchData() async {
    final response = await http
        .get(Uri.parse('https://hackathons.lk/wp-json/wp/v2/event?_embed'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new Data.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {
    super.initState();
    eventData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Hackathon.lk logo -------------------------------------------------------------------------------
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Image.asset(
              'lib/assets/Hackathons.lk-logo-black.png',
              width: 220,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          //* Title text
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Event Calendar',
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 5),
          Flexible(
            child: FutureBuilder(
              future: eventData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Data> data = snapshot.data;

                  formatEventData() {
                    for (int count = 0; count < data.length; count++) {
                      formattedEventData[DateTime.parse(DateFormat('MM/dd/yyyy')
                              .parse(data[count].eventStartDate)
                              .toString() +
                          'Z')] = [data[count]];
                    }
                  }

                  formatEventData();

                  _getEventsForDay(DateTime day) {
                    return formattedEventData[day] ?? [];
                  }

                  return ScrollGlowDisabler(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          //* Main Card shadow
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            // the box shawdow property allows for fine tuning as aposed to shadowColor
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.black54,
                                // offset, the X,Y coordinates to offset the shadow
                                offset: new Offset(5.0, 5.0),
                                // blurRadius, the higher the number the more smeared look
                                blurRadius: 36.0,
                                spreadRadius: -23,
                              )
                            ],
                          ),
                          //* Event Card ----------------------------------------------------------------------
                          child: Card(
                            elevation: 0,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: TableCalendar(
                              firstDay: DateTime(2019, 1, 1),
                              lastDay: DateTime(2025, 12, 31),
                              focusedDay: _focusedDay,
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                if (!isSameDay(_selectedDay, selectedDay)) {
                                  setState(() {
                                    _focusedDay = focusedDay;
                                    _selectedDay = selectedDay;
                                    _selectedEvents =
                                        _getEventsForDay(selectedDay);
                                  });
                                }
                              },
                              //* Load events in calendar
                              eventLoader: (day) {
                                return _getEventsForDay(day);
                              },
                              //* Calendar header style
                              headerStyle: HeaderStyle(
                                titleCentered: true,
                                formatButtonVisible: false,
                                titleTextStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              daysOfWeekStyle: DaysOfWeekStyle(
                                weekdayStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                weekendStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              //* Calendar style
                              calendarStyle: CalendarStyle(
                                selectedDecoration: BoxDecoration(
                                  color: Color(0xff1976D2),
                                  shape: BoxShape.circle,
                                ),
                                todayDecoration: BoxDecoration(
                                  color: Color(0x991976D2),
                                  shape: BoxShape.circle,
                                ),
                                defaultTextStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                weekendTextStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                outsideTextStyle: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                              //* Calendar marker style
                              calendarBuilders: CalendarBuilders(
                                // ignore: missing_return
                                markerBuilder: (context, day, events) {
                                  if (events.isNotEmpty &&
                                      day == _selectedDay) {
                                    return Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 11),
                                        height: 6,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        //* Title text
                        if (_selectedEvents.isNotEmpty)
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              DateFormat('MMMM d, yyyy').format(_selectedDay),
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        SizedBox(height: 5),
                        if (_selectedEvents.isNotEmpty)
                          eventCard(_selectedEvents)
                      ],
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[400],
                        child: Container(
                          height: 400,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  //* Event Card design
  eventCard(_selectedEvents) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
        //* Main Card shadow
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          // the box shawdow property allows for fine tuning as aposed to shadowColor
          boxShadow: [
            new BoxShadow(
              color: Colors.black54,
              // offset, the X,Y coordinates to offset the shadow
              offset: new Offset(5.0, 5.0),
              // blurRadius, the higher the number the more smeared look
              blurRadius: 36.0,
              spreadRadius: -23,
            )
          ],
        ),
        //* Event Card ----------------------------------------------------------------------
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Hero(
                    tag: _selectedEvents[0].image + '3',
                    transitionOnUserGestures: true,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          //* Cache Image viewer
                          CachedNetworkImage(
                            fadeInDuration: Duration(milliseconds: 200),
                            imageUrl: _selectedEvents[0].image,
                            placeholder: (context, url) =>
                                //* Image loading shimmer
                                Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[400],
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //* Event Status
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
                                color: Color(0xff1976D2),
                                child: Text(
                                  _selectedEvents[0].status,
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              //* Event Views
                              Container(
                                margin: EdgeInsets.only(bottom: 10, right: 10),
                                padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye_rounded,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      _selectedEvents[0].views,
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* Title text
                      Text(
                        _selectedEvents[0].title,
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff707070),
                        ),
                      ),
                      Wrap(
                        children: [
                          //* Location
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color(0xff1976D2),
                                size: 20,
                              ),
                              SizedBox(width: 2),
                              Text(
                                _selectedEvents[0].eventLocation,
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1976D2),
                                ),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                          //* Date
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Customicons.calendar_alt,
                                color: Color(0xff1976D2),
                                size: 18,
                              ),
                              SizedBox(width: 5),
                              Text(
                                DateFormat('MMMM d, yyyy')
                                    .format(DateFormat('MM/dd/yyyy').parse(
                                        _selectedEvents[0].eventStartDate))
                                    .toString(),
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1976D2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventInnerScreen(
              eventData: _selectedEvents[0],
              sectionId: '3',
            ),
          ),
        );
      },
    );
  }
}
