import 'package:flutter/material.dart';
import 'package:reachme/constants/Constantcolors.dart';

class Chatroom extends StatefulWidget {
  Chatroom({Key key}) : super(key: key);

  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.redColor,
    );
  }
}
