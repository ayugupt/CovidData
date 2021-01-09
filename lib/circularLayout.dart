import 'package:flutter/material.dart';
import 'dart:math';

class CircularLayout extends StatefulWidget {
  CircularLayoutState createState() => CircularLayoutState();
}

class CircularLayoutState extends State<CircularLayout> {
  Widget customButton(double radius, IconData icon, Color color) {
    double iconSpacer = radius / 5;
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(radius)),
        width: radius * 2,
        height: radius * 2,
        child: Icon(
          icon,
          size: (radius - iconSpacer) * 2,
        ),
      ),
      onTap: () {
        print("hi");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double bigButtonRadius = MediaQuery.of(context).size.width * 0.25;
    double smallButtonRadius = MediaQuery.of(context).size.width * 0.09;
    double space = MediaQuery.of(context).size.width * 0.12;
    double appBarHeight = MediaQuery.of(context).size.height * 0;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              top: MediaQuery.of(context).size.height * 0.5 -
                  bigButtonRadius -
                  appBarHeight,
              left: MediaQuery.of(context).size.width * 0.5 - bigButtonRadius,
              child: customButton(bigButtonRadius, Icons.ac_unit, Colors.blue)),
          Positioned(
            child:
                customButton(smallButtonRadius, Icons.access_alarm, Colors.red),
            top: MediaQuery.of(context).size.height * 0.5 -
                smallButtonRadius -
                appBarHeight,
            left: MediaQuery.of(context).size.width * 0.5 -
                smallButtonRadius -
                bigButtonRadius -
                space,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5 -
                (bigButtonRadius + space) / sqrt(2) -
                smallButtonRadius -
                appBarHeight,
            left: MediaQuery.of(context).size.width * 0.5 -
                (bigButtonRadius + space) / sqrt(2) -
                smallButtonRadius,
            child: customButton(
                smallButtonRadius, Icons.access_alarm, Colors.blue),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.5 -
                  bigButtonRadius -
                  space -
                  smallButtonRadius -
                  appBarHeight,
              left: MediaQuery.of(context).size.width * 0.5 - smallButtonRadius,
              child: customButton(
                  smallButtonRadius, Icons.access_alarm, Colors.red)),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.5 -
                  (bigButtonRadius + space) / sqrt(2) -
                  smallButtonRadius -
                  appBarHeight,
              left: MediaQuery.of(context).size.width * 0.5 +
                  (bigButtonRadius + space) / sqrt(2) -
                  smallButtonRadius,
              child: customButton(
                  smallButtonRadius, Icons.access_alarm, Colors.blue)),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5 -
                smallButtonRadius -
                appBarHeight,
            left: MediaQuery.of(context).size.width * 0.5 +
                bigButtonRadius +
                space -
                smallButtonRadius,
            child:
                customButton(smallButtonRadius, Icons.access_alarm, Colors.red),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5 +
                (bigButtonRadius + space) / sqrt(2) -
                smallButtonRadius -
                appBarHeight,
            left: MediaQuery.of(context).size.width * 0.5 -
                (bigButtonRadius + space) / sqrt(2) -
                smallButtonRadius,
            child: customButton(
                smallButtonRadius, Icons.access_alarm, Colors.blue),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5 +
                (bigButtonRadius + space) / sqrt(2) -
                smallButtonRadius -
                appBarHeight,
            left: MediaQuery.of(context).size.width * 0.5 +
                (bigButtonRadius + space) / sqrt(2) -
                smallButtonRadius,
            child: customButton(
                smallButtonRadius, Icons.access_alarm, Colors.blue),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5 -
                smallButtonRadius +
                space +
                bigButtonRadius -
                appBarHeight,
            left: MediaQuery.of(context).size.width * 0.5 - smallButtonRadius,
            child:
                customButton(smallButtonRadius, Icons.access_alarm, Colors.red),
          ),
        ],
      ),
      //appBar: AppBar(),
    );
  }
}
