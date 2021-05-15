import 'package:flutter/cupertino.dart';
import 'package:hackathons_lk_app/screens/event_inner_screen.dart';
import 'package:hackathons_lk_app/services/customicons_icons.dart';

import 'package:flutter/material.dart';
import 'package:hackathons_lk_app/services/api_data.dart';
import 'package:hackathons_lk_app/services/allEvents_PostsController.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

ScrollController allEventsScrollController = new ScrollController();

class AllEventsSection extends StatefulWidget {
  final Future<List<Data>> eventData;
  AllEventsSection({@required this.eventData});

  @override
  _AllEventsSectionState createState() => _AllEventsSectionState();
}

class _AllEventsSectionState extends State<AllEventsSection> {
  final AllEventsPostsController postsController =
      Get.put(AllEventsPostsController());
  int _page = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await postsController.fetchPosts(pageNumber: 1);
    });

    //* events list scroll controller
    allEventsScrollController.addListener(() async {
      if (allEventsScrollController.position.pixels ==
              allEventsScrollController.position.maxScrollExtent &&
          isLoaded.value &&
          _page <= postsController.totalPages.value) {
        await postsController.fetchPosts(pageNumber: ++_page);
      }
    });
  }

  @override
  void dispose() {
    allEventsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder<bool>(
          valueListenable: isLoaded,
          builder: (BuildContext context, bool isLoaded, Widget child) {
            //* Events loading shimmer ------------------------------------------------------------------
            if (postsController.eventsList.isEmpty) {
              return ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[400],
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[400],
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[400],
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              //* events list ---------------------------------------------------------------------------
              return ListView.builder(
                  padding: EdgeInsets.zero,
                  controller: allEventsScrollController,
                  itemCount: postsController.eventsList.length,
                  itemBuilder: (context, index) {
                    //* bottom loading indicator
                    if ((index == postsController.eventsList.length - 1) &&
                        (_page <= postsController.totalPages.value)) {
                      return Center(
                        child: Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: CupertinoActivityIndicator()),
                      );
                    }

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
                                    tag: postsController
                                            .eventsList[index].image +
                                        '0',
                                    transitionOnUserGestures: true,
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                          //* Cache Image viewer
                                          CachedNetworkImage(
                                            fadeInDuration:
                                                Duration(milliseconds: 200),
                                            imageUrl: postsController
                                                .eventsList[index].image,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //* Event Status
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                padding: EdgeInsets.fromLTRB(
                                                    6, 4, 6, 4),
                                                color: (postsController
                                                            .eventsList[index]
                                                            .status ==
                                                        'Upcoming')
                                                    ? Color(0xff1976D2)
                                                    : Colors.grey[700],
                                                child: Text(
                                                  postsController
                                                      .eventsList[index].status,
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
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 4, 8, 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.black87,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .remove_red_eye_rounded,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      postsController
                                                          .eventsList[index]
                                                          .views,
                                                      style: TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //* Title text
                                      Text(
                                        (postsController
                                                .eventsList[index].title)
                                            .replaceAll('&#8211;', '-')
                                            .replaceAll('&#038;', '&'),
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
                                                size: 18,
                                              ),
                                              SizedBox(width: 2),
                                              Flexible(
                                                child: Text(
                                                  postsController
                                                      .eventsList[index]
                                                      .eventLocation,
                                                  style: TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff1976D2),
                                                  ),
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
                                                size: 16,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                DateFormat('MMMM d, yyyy')
                                                    .format(DateFormat(
                                                            'MM/dd/yyyy')
                                                        .parse(postsController
                                                            .eventsList[index]
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
                              eventData: postsController.eventsList[index],
                              sectionId: '0',
                            ),
                          ),
                        );
                      },
                    );
                  });
            }
          }),
    );
  }
}
