import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reachme/constants/Constantcolors.dart';
import 'package:reachme/screens/LandingPage/landing_helpers.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.whiteColor,
      body: Stack(
        children: [
          bodyColor(),
          Provider.of<LandingHelpers>(context, listen: false)
              .bodyImage(context),
          Provider.of<LandingHelpers>(context, listen: false)
              .taglineText(context),
          Provider.of<LandingHelpers>(context, listen: false)
              .signInButtons(context),
        ],
      ),
    );
  }

  Widget bodyColor() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.5, 0.9],
        colors: [constantColors.darkColor, constantColors.blueGreyColor],
      )),
    );
  }
}
