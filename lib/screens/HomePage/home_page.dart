import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reachme/constants/Constantcolors.dart';
import 'package:reachme/screens/Chatroom/chatroom.dart';
import 'package:reachme/screens/Feed/feed.dart';
import 'package:reachme/screens/HomePage/homepage_helpers.dart';
import 'package:reachme/screens/Profile/profile.dart';
import 'package:reachme/services/firebase_operations.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<FirebaseOperations>(context, listen: false)
        .initUserData(context);
  }

  ConstantColors constantColors = ConstantColors();
  final PageController homePageController = PageController();
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: constantColors.darkColor,
          body: PageView(
            controller: homePageController,
            children: [
              Feed(),
              Chatroom(),
              Profile(),
            ],
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (page) {
              setState(() {
                pageIndex = page;
              });
            },
          ),
          bottomNavigationBar:
              Provider.of<HomepageHelpers>(context, listen: false)
                  .bottomNavBar(pageIndex, homePageController, context)),
    );
  }
}
