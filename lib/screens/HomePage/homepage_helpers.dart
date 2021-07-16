import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reachme/constants/Constantcolors.dart';
import 'package:reachme/services/firebase_operations.dart';

class HomepageHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  Widget bottomNavBar(
      int index, PageController pageController, BuildContext context) {
    return CustomNavigationBar(
      items: [
        CustomNavigationBarItem(icon: Icon(EvaIcons.home)),
        CustomNavigationBarItem(icon: Icon(Icons.message_rounded)),
        CustomNavigationBarItem(
            icon: CircleAvatar(
          radius: 35,
          backgroundColor: constantColors.blueGreyColor,
          backgroundImage: NetworkImage(Provider.of<FirebaseOperations>(context)
                  .initUserImage ??
              'https://images.unsplash.com/photo-1444703686981-a3abbc4d4fe3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlZHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80'),
        )),
      ],
      currentIndex: index,
      bubbleCurve: Curves.bounceIn,
      scaleCurve: Curves.decelerate,
      selectedColor: constantColors.whiteColor,
      unSelectedColor: constantColors.blueColor,
      strokeColor: constantColors.whiteColor,
      scaleFactor: 0.5,
      iconSize: 30,
      onTap: (val) {
        index = val;
        pageController.jumpToPage(index);
        notifyListeners();
      },
      backgroundColor: Color(0xff040307),
    );
  }
}
