import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reachme/constants/Constantcolors.dart';
import 'package:reachme/screens/LandingPage/landing_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
              child: LandingPage(),
              type: PageTransitionType.fade,
            )));
  }

  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      body: Center(
        child: RichText(
          text: TextSpan(
            text: 'Reach',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: constantColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Me',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: constantColors.blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
