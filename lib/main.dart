import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathons_lk_app/screens/about_screen.dart';
import 'package:hackathons_lk_app/screens/calendar_screen.dart';
import 'package:hackathons_lk_app/screens/events_screen.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:hackathons_lk_app/services/customicons_icons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hackathons_lk_app/sections/all_events_section.dart';
import 'package:hackathons_lk_app/sections/ended_events_section.dart';
import 'package:hackathons_lk_app/sections/upcoming_events_section.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(HackathonsLK()));
}

class HackathonsLK extends StatefulWidget {
  @override
  _HackathonsLKState createState() => _HackathonsLKState();
}

class _HackathonsLKState extends State<HackathonsLK> {
  Color colorMain = Color(0xff939AA4);
  Color colorSelected = Color(0xffffffff);

  int _selectedIndex = 0;
  final List<Widget> _menus = [EventsScreen(), CalendarScreen(), AboutScreen()];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      theme: ThemeData(
        accentColor: Color(0xff1976D2),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: Color(0xfff8f8f8),
      ),
      home: Scaffold(
        bottomNavigationBar: navigationBar(),
        body: IndexedStack(
          index: _selectedIndex,
          children: _menus,
        ),
      ),
    );
  }

  navigationBar() {
    return BubbleBottomBar(
      opacity: 1,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      elevation: 8,
      //fabLocation: BubbleBottomBarFabLocation.end, //new
      //hasNotch: true, //new
      hasInk: true, //new, gives a cute ink effect
      inkColor:
          Colors.transparent, //optional, uses theme color if not specified
      iconSize: 18,
      backgroundColor: Color(0xffE8E8E8),
      items: <BubbleBottomBarItem>[
        //* Events Items
        BubbleBottomBarItem(
          backgroundColor: Color(0xff1976D2),
          icon: Icon(
            Customicons.events,
            color: colorMain,
          ),
          activeIcon: Container(
            width: 0,
            child: Icon(
              Customicons.events,
              color: colorSelected,
            ),
          ),
          title: Text(
            "Events",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16),
            textAlign: TextAlign.left,
          ),
        ),
        //* Calendar Item
        BubbleBottomBarItem(
          backgroundColor: Color(0xff1976D2),
          icon: Icon(
            Customicons.calendar_alt,
            color: colorMain,
          ),
          activeIcon: Container(
            width: 0,
            child: Icon(
              Customicons.calendar_alt,
              color: colorSelected,
            ),
          ),
          title: Text(
            "Calendar",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
        //* About Item
        BubbleBottomBarItem(
          backgroundColor: Color(0xff1976D2),
          icon: Icon(
            Customicons.info_circle,
            color: colorMain,
          ),
          activeIcon: Container(
            width: 0,
            child: Icon(
              Customicons.info_circle,
              color: colorSelected,
            ),
          ),
          title: Text(
            "About",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16),
          ),
        )
      ],
    );
  }

  _onItemTapped(int index) {
    allEventsScrollController.animateTo(
        allEventsScrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }
}
