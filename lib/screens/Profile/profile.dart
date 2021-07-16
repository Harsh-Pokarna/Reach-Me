import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eva_icons_flutter/icon_data.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:reachme/constants/Constantcolors.dart';
import 'package:reachme/screens/LandingPage/landing_page.dart';
import 'package:reachme/screens/Profile/profile_helpers.dart';
import 'package:reachme/services/Authentication.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              EvaIcons.settings2Outline,
              color: constantColors.greenColor,
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
                icon: Icon(EvaIcons.logOutOutline,
                    color: constantColors.blueColor),
                onPressed: () {
                  Provider.of<Authentication>(context, listen: false)
                      .logOutviaEmail()
                      .whenComplete(() => Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: LandingPage(),
                            type: PageTransitionType.fade,
                          )));
                })
          ],
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: constantColors.blueGreyColor.withOpacity(0.4),
          title: Text(
            'My Profile',
            style: TextStyle(
              color: constantColors.whiteColor,
              fontSize: 20,
            ),
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: constantColors.blueGreyColor.withOpacity(0.6),
        ),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(Provider.of<Authentication>(context, listen: false)
                  .getUserUid)
              .snapshots(),
          // initialData: initialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Provider.of<ProfileHelpers>(context, listen: false)
                          .headerProfile(context, snapshot),
                    ),
                    Provider.of<ProfileHelpers>(context, listen: false)
                        .divider(context),
                    Provider.of<ProfileHelpers>(context, listen: false)
                        .middleProfile(context, snapshot),
                    Provider.of<ProfileHelpers>(context, listen: false)
                        .footerProfile(context, snapshot),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
