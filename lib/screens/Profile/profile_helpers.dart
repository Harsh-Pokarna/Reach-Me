import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reachme/constants/Constantcolors.dart';

class ProfileHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  Widget headerProfile(BuildContext context, AsyncSnapshot snapshot) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // color: constantColors.redColor,
            height: 200,
            width: 180,
            child: Column(
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: constantColors.transperant,
                    radius: 60,
                    backgroundImage:
                        NetworkImage(snapshot.data.data()['userimage']),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    snapshot.data.data()['username'],
                    style: TextStyle(
                        color: constantColors.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        EvaIcons.email,
                        color: constantColors.greenColor,
                        size: 16,
                      ),
                      Text(
                        snapshot.data.data()['useremail'],
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: constantColors.darkColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 70,
                        width: 80,
                        child: Column(
                          children: [
                            Text('0',
                                style: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontSize: 28)),
                            Text('Followers',
                                style: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontSize: 12)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: constantColors.darkColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 70,
                        width: 80,
                        child: Column(
                          children: [
                            Text('0',
                                style: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontSize: 28)),
                            Text('Following',
                                style: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: constantColors.darkColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 70,
                  width: 80,
                  child: Column(
                    children: [
                      Text('0',
                          style: TextStyle(
                              color: constantColors.whiteColor, fontSize: 28)),
                      Text('Posts',
                          style: TextStyle(
                              color: constantColors.whiteColor, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget divider(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 25,
        width: 350,
        child: Divider(
          color: constantColors.whiteColor,
        ),
      ),
    );
  }

  Widget middleProfile(BuildContext context, dynamic snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
          ),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.userAstronaut,
                  color: constantColors.yellowColor, size: 16),
              SizedBox(
                width: 10,
              ),
              Text(
                'Recently Added',
                style: TextStyle(
                  fontSize: 16,
                  color: constantColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            color: constantColors.darkColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ],
    );
  }

  Widget footerProfile(BuildContext context, dynamic snapshot) {
    return Container(
      child: Image.asset('assets/images/empty.png'),
      margin: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.57,
      decoration: BoxDecoration(
        color: constantColors.darkColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
