import 'package:flutter/material.dart';
import 'package:reachme/constants/Constantcolors.dart';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.whiteColor,
    );
  }
}
