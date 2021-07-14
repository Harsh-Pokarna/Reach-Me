import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:reachme/constants/Constantcolors.dart';
import 'package:reachme/screens/HomePage/home_page.dart';
import 'package:reachme/screens/LandingPage/landing_services.dart';
import 'package:reachme/screens/LandingPage/landing_utils.dart';
import 'package:reachme/services/Authentication.dart';

class LandingHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  Widget bodyImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login.png'),
        ),
      ),
    );
  }

  Widget taglineText(BuildContext context) {
    return Positioned(
      child: Container(
        constraints: BoxConstraints(maxWidth: 200),
        child: RichText(
          text: TextSpan(
            text: 'Sign ',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: constantColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'In ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: constantColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              TextSpan(
                text: 'With',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: constantColors.blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
      ),
      top: MediaQuery.of(context).size.height * 0.58,
      left: 10,
    );
  }

  Widget signInButtons(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.8,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                emailAuthSheet(context);
              },
              child: Container(
                width: 80,
                height: 40,
                child: Icon(
                  EvaIcons.emailOutline,
                  color: constantColors.yellowColor,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: constantColors.yellowColor),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Provider.of<Authentication>(context, listen: false)
                    .signInWithGoogle()
                    .whenComplete(
                      () => Navigator.of(context).pushReplacement(
                        PageTransition(
                            child: HomePage(),
                            type: PageTransitionType.leftToRightWithFade),
                      ),
                    );
              },
              child: Container(
                width: 80,
                height: 40,
                child: Icon(
                  FontAwesomeIcons.google,
                  color: constantColors.redColor,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: constantColors.redColor),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                width: 80,
                height: 40,
                child: Icon(
                  FontAwesomeIcons.facebook,
                  color: constantColors.blueColor,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: constantColors.blueColor),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
  }

  emailAuthSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 85,
                  child: Divider(
                    thickness: 4,
                    color: constantColors.whiteColor,
                  ),
                ),
                Provider.of<LandingService>(context, listen: false)
                    .passwordLessSignin(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<LandingService>(context, listen: false)
                            .loginSheet(context);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(constantColors.blueColor),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<LandingUtils>(context, listen: false)
                            .selectAvatarOptionsSheet(context);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(constantColors.redColor),
                      ),
                      child: Text(
                        'Signin',
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
