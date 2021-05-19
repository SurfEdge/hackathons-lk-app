import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hackathons_lk_app/services/customicons_icons.dart';
import 'package:hackathons_lk_app/services/api_data.dart';
import 'package:hackathons_lk_app/services/scroll_glow_disabler.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class EventInnerScreen extends StatefulWidget {
  final Data eventData;
  final String sectionId;
  EventInnerScreen({@required this.eventData, @required this.sectionId});

  @override
  _EventInnerScreenState createState() => _EventInnerScreenState();
}

class _EventInnerScreenState extends State<EventInnerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: ScrollGlowDisabler(
          child: Column(
            children: [
              Flexible(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Hero(
                      tag: '${widget.eventData.image}${widget.sectionId}',
                      transitionOnUserGestures: true,
                      child: Material(
                        type: MaterialType.transparency,
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            //* Cache Image viewer
                            Stack(
                              children: [
                                CachedNetworkImage(
                                  fadeInDuration: Duration(milliseconds: 200),
                                  imageUrl: widget.eventData.image,
                                ),
                                //* Back button
                                InkWell(
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    decoration: BoxDecoration(
                                        color: Color(0xff1976D2),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  onTap: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //* Event Status
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
                                  color: (widget.eventData.status == 'Upcoming')
                                      ? Color(0xff1976D2)
                                      : Colors.grey[700],
                                  child: Text(
                                    widget.eventData.status,
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
                                  margin:
                                      EdgeInsets.only(bottom: 10, right: 10),
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
                                        widget.eventData.views,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //* Title text
                          Text(
                            (widget.eventData.title)
                                .replaceAll('&#8211;', '-')
                                .replaceAll('&#038;', '&'),
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff707070),
                            ),
                          ),
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
                              Flexible(
                                child: Text(
                                  widget.eventData.eventLocation,
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff1976D2),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                            //* DateTime Card shadow
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
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Starts:',
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  //* Starting date and time
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(width: 15),
                                      Flexible(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Customicons.calendar_alt,
                                              color: Color(0xff1976D2),
                                              size: 17,
                                            ),
                                            SizedBox(width: 6),
                                            //* Start date
                                            Text(
                                              DateFormat('MM.dd.yyyy')
                                                  .format(
                                                      DateFormat('MM/dd/yyyy')
                                                          .parse(widget
                                                              .eventData
                                                              .eventStartDate))
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff1976D2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        fit: FlexFit.loose,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(width: 15),
                                            Icon(
                                              Customicons.icon_ionic_ios_time,
                                              color: Color(0xff1976D2),
                                              size: 17,
                                            ),
                                            SizedBox(width: 6),
                                            //* Start time
                                            Text(
                                              widget.eventData.eventStartTime,
                                              style: TextStyle(
                                                fontFamily: 'poppins',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff1976D2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'End:',
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  //* Ending date and time
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(width: 15),
                                      Flexible(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Customicons.calendar_alt,
                                              color: Color(0xff1976D2),
                                              size: 17,
                                            ),
                                            SizedBox(width: 6),
                                            //* End date
                                            Text(
                                              DateFormat('MM.dd.yyyy')
                                                  .format(
                                                      DateFormat('MM/dd/yyyy')
                                                          .parse(widget
                                                              .eventData
                                                              .eventEndDate))
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff1976D2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(width: 15),
                                            Icon(
                                              Customicons.icon_ionic_ios_time,
                                              color: Color(0xff1976D2),
                                              size: 17,
                                            ),
                                            SizedBox(width: 6),
                                            //* End time
                                            Text(
                                              widget.eventData.eventEndTime,
                                              style: TextStyle(
                                                fontFamily: 'poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff1976D2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Html(
                            data: (widget.eventData.content)
                                .replaceAll('</p>\n<p>&nbsp;</p>\n', ''),
                            blacklistedElements: ['img'],
                            onLinkTap: (url) async {
                              await canLaunch(url)
                                  ? await launch(url)
                                  : throw 'Could not launch $url';
                            },
                          ),
                          SizedBox(height: 10),
                          //* Contact number
                          if (widget.eventData.contact != '')
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 20,
                                ),
                                SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    widget.eventData.contact,
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              //* Mail button
                              InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(right: 12),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0xff1976D2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                ),
                                //* Mail to hackathon.lk
                                onTap: () async {
                                  await canLaunch(
                                          'mailto:${widget.eventData.email}')
                                      ? await launch(
                                          'mailto:${widget.eventData.email}')
                                      : throw 'Could not launch mailto:${widget.eventData.email}';
                                },
                              ),
                              //* Website button
                              InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(right: 12),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0xff1976D2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Customicons.globe,
                                    color: Colors.white,
                                  ),
                                ),
                                //* Open hackathon.lk website
                                onTap: () async {
                                  await canLaunch(widget.eventData.website)
                                      ? await launch(widget.eventData.website)
                                      : throw 'Could not launch ${widget.eventData.website}';
                                },
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          if (!(widget.eventData.facebook == '' &&
                              widget.eventData.twitter == '' &&
                              widget.eventData.linkedin == ''))
                            Text(
                              'Social Links',
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff707070),
                              ),
                            ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              //* Facebook button
                              if (widget.eventData.facebook != '')
                                InkWell(
                                  child: Icon(
                                    Customicons.facebook_square,
                                    size: 40,
                                  ),
                                  onTap: () async {
                                    await canLaunch(widget.eventData.facebook)
                                        ? await launch(
                                            widget.eventData.facebook)
                                        : throw 'Could not launch ${widget.eventData.facebook}';
                                  },
                                ),
                              if (widget.eventData.facebook != '')
                                SizedBox(width: 3),
                              //* Twitter button
                              if (widget.eventData.twitter != '')
                                InkWell(
                                  child: Icon(
                                    Customicons.twitter_square,
                                    size: 40,
                                  ),
                                  onTap: () async {
                                    await canLaunch(widget.eventData.twitter)
                                        ? await launch(widget.eventData.twitter)
                                        : throw 'Could not launch ${widget.eventData.twitter}';
                                  },
                                ),
                              if (widget.eventData.twitter != '')
                                SizedBox(width: 3),
                              //* LinkedIn button
                              if (widget.eventData.linkedin != '')
                                InkWell(
                                  child: Icon(
                                    Customicons.linkedin,
                                    size: 40,
                                  ),
                                  onTap: () async {
                                    await canLaunch(widget.eventData.linkedin)
                                        ? await launch(
                                            widget.eventData.linkedin)
                                        : throw 'Could not launch ${widget.eventData.linkedin}';
                                  },
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.eventData.status == 'Upcoming')
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    children: [
                      Flexible(
                        //* Register now button
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            primary: Colors.grey,
                            backgroundColor: Color(0xff1B9120),
                          ),
                          onPressed: () async {
                            await canLaunch(widget.eventData.register)
                                ? await launch(widget.eventData.register)
                                : throw 'Could not launch ${widget.eventData.register}';
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_add, color: Colors.white),
                              SizedBox(width: 5),
                              Text(
                                "Register Now",
                                style: TextStyle(
                                  fontFamily: 'sf',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      //* Add to caledar button
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Color(0xff1976D2), shape: BoxShape.circle),
                          child: Icon(
                            Customicons.calendar_plus,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Add2Calendar.addEvent2Cal(
                            Event(
                              title: widget.eventData.title,
                              location: widget.eventData.eventLocation,
                              startDate: DateFormat('MM/dd/yyyy hh:mm aaa')
                                  .parse(widget.eventData.eventStartDate +
                                      ' ' +
                                      widget.eventData.eventStartTime),
                              endDate: DateFormat('MM/dd/yyyy hh:mm aaa').parse(
                                  widget.eventData.eventEndDate +
                                      ' ' +
                                      widget.eventData.eventEndTime),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
