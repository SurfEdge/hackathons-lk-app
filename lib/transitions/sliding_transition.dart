import 'package:flutter/material.dart';

class SlidingTransition extends PageRouteBuilder {
  Widget widget;
  SlidingTransition({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: Duration(milliseconds: 250),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            Animation<Offset> custom =
                Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
                    .animate(animation);
            return SlideTransition(position: custom, child: child);
          },
        );
}
