import 'package:flutter/material.dart';
import 'package:hackathons_lk_app/sections/all_events_section.dart';
import 'package:hackathons_lk_app/sections/ended_events_section.dart';
import 'package:hackathons_lk_app/sections/upcoming_events_section.dart';
import 'package:hackathons_lk_app/services/scroll_glow_disabler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class Data {
  final String name;
  final String title;
  final String eventLocation;
  final String eventStartDate;
  final String eventStartTime;
  final String eventEndDate;
  final String eventEndTime;
  final String status;
  final String website;
  final String image;
  final String views;

  Data(
      {this.name,
      this.title,
      this.eventLocation,
      this.eventStartDate,
      this.eventStartTime,
      this.eventEndDate,
      this.eventEndTime,
      this.status,
      this.website,
      this.image,
      this.views});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'],
      title: json['title']['rendered'].toString(),
      eventLocation: json['event_location'],
      eventStartDate: json['event_start_date'],
      eventStartTime: json['event_start_time'],
      eventEndDate: json['event_end_date'],
      eventEndTime: json['event_end_time'],
      status: (json['event_status'] == 'upcoming') ? 'Upcoming' : 'Ended',
      website: json['event_website'],
      image: json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']
          ['medium_large']['source_url'],
      views: json['post_views_count'],
    );
  }
}

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  Future<List<Data>> eventData;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    eventData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Flexible(
              child: ScrollGlowDisabler(
                  //* Top Tab Bar ------------------------------------------------------------------------------
                  child: DefaultTabController(
                length: 3, // length of tabs
                initialIndex: 0,
                child: Container(
                  height: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        //* Tab bar customize
                        child: TabBar(
                          isScrollable: false,
                          indicatorColor: Colors.transparent,
                          labelColor: Colors.black,
                          unselectedLabelColor: Color(0xffA4A4A4),
                          labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          unselectedLabelStyle: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          tabs: [
                            Tab(text: 'All'),
                            Tab(text: 'Upcoming'),
                            Tab(text: 'Ended'),
                          ],
                          onTap: (index) {
                            setState(() {
                              _tabIndex = index;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        //* Tab Content
                        child: Container(
                          height: 500,
                          child: IndexedStack(
                            index: _tabIndex,
                            children: <Widget>[
                              AllEventsSection(
                                eventData: eventData,
                              ), //* All Events Section
                              UpcomingEventsSection(), //* Upcoming Events Section
                              EndedEventsSection(), //* Ended Events Section
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}