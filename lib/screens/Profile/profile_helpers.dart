import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reachme/constants/Constantcolors.dart';

class ProfileHelpers with ChangeNotifier {
  Widget headerProfile(BuildContext context, AsyncSnapshot snapshot) {
    ConstantColors constantColors = ConstantColors();
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
}
