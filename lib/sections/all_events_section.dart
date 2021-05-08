import 'package:flutter/material.dart';
import 'package:hackathons_lk_app/screens/events_screen.dart';
import 'package:hackathons_lk_app/services/customicons_icons.dart';
import 'package:intl/intl.dart';

class AllEventsSection extends StatefulWidget {
  final Future<List<Data>> eventData;
  AllEventsSection({@required this.eventData});

  @override
  _AllEventsSectionState createState() => _AllEventsSectionState();
}

class _AllEventsSectionState extends State<AllEventsSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: widget.eventData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Data> data = snapshot.data;
            print(data[0].image);
            return ListView.builder(
              padding: EdgeInsets.zero,
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
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
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                //* Image
                                Image.network(
                                  data[index].image,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //* Event Status
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
                                      color: Color(0xff1976D2),
                                      child: Text(
                                        data[index].status,
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
                                      margin: EdgeInsets.only(
                                          bottom: 10, right: 10),
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
                                            data[index].views,
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
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 5, 10, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //* Title text
                                Text(
                                  data[index].title,
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
                                          data[index].eventLocation,
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
                                              .format(DateFormat('MM/dd/yyyy')
                                                  .parse(data[index]
                                                      .eventStartDate))
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
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}