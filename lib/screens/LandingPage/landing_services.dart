import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:reachme/constants/Constantcolors.dart';
import 'package:reachme/screens/HomePage/home_page.dart';
import 'package:reachme/screens/LandingPage/landing_utils.dart';
import 'package:reachme/services/Authentication.dart';
import 'package:reachme/services/firebase_operations.dart';

class LandingService with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ConstantColors constantColors = ConstantColors();
  Widget passwordLessSignin(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          // initialData: initialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                physics: BouncingScrollPhysics(),
                children: snapshot.data.docs
                    .map<Widget>((DocumentSnapshot documentSnapshot) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          (documentSnapshot.data() as dynamic)['userimage']),
                    ),
                    title: Text(
                        (documentSnapshot.data() as dynamic)['username']
                            .toString(),
                        style: TextStyle(
                            color: constantColors.greenColor,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        (documentSnapshot.data() as dynamic)['useremail']
                            .toString(),
                        style: TextStyle(
                            color: constantColors.whiteColor, fontSize: 12)),
                    trailing: IconButton(
                      icon: Icon(FontAwesomeIcons.trashAlt,
                          color: constantColors.redColor),
                      onPressed: () {},
                    ),
                  );
                }).toList(),
              );
            }
          }),
    );
  }

  signInSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
                CircleAvatar(
                  backgroundImage: FileImage(
                      Provider.of<LandingUtils>(context, listen: false)
                          .getUserAvatar),
                  backgroundColor: constantColors.transperant,
                  radius: 60,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                      color: constantColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                      color: constantColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Passsword',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                      color: constantColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (emailController.text != null) {
                      Provider.of<Authentication>(context, listen: false)
                          .createAccount(
                              emailController.text, passwordController.text)
                          .whenComplete(() {
                        Provider.of<FirebaseOperations>(context, listen: false)
                            .createUserCollection(context, {
                          'useruid': Provider.of<Authentication>(context,
                                  listen: false)
                              .getUserUid,
                          'useremail': emailController.text,
                          'username': usernameController.text,
                          'userimage':
                              Provider.of<LandingUtils>(context, listen: false)
                                  .getUserAvatarUrl,
                        });
                      }).whenComplete(
                        () => Navigator.of(context).pushReplacement(
                          PageTransition(
                              child: HomePage(),
                              type: PageTransitionType.bottomToTop),
                        ),
                      );
                    }
                  },
                  backgroundColor: constantColors.blueColor,
                  child: Icon(
                    FontAwesomeIcons.check,
                    color: constantColors.greenColor,
                  ),
                )
              ],
            ),
          );
        });
  }

  loginSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Container(
            height: 330,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                      color: constantColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Passsword',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(
                      color: constantColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (emailController.text != null) {
                      logIntoYourAccount(context);
                    }
                  },
                  backgroundColor: constantColors.blueColor,
                  child: Icon(
                    FontAwesomeIcons.check,
                    color: constantColors.greenColor,
                  ),
                )
              ],
            ),
          );
        });
  }

  logIntoYourAccount(BuildContext context) async {
    try {
      await Provider.of<Authentication>(context, listen: false)
          .logIntoAccount(emailController.text, passwordController.text);
      Navigator.of(context).pushReplacement(
        PageTransition(child: HomePage(), type: PageTransitionType.bottomToTop),
      );
    } on FirebaseAuthException catch (error) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('An error occured'),
            );
          });
    }
  }

  showUserAvatar(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                Container(
                  width: 85,
                  child: Divider(
                    thickness: 4,
                    color: constantColors.whiteColor,
                  ),
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundColor: constantColors.transperant,
                  backgroundImage: FileImage(
                      Provider.of<LandingUtils>(context, listen: false)
                          .getUserAvatar),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Provider.of<LandingUtils>(context, listen: false)
                              .pickUserAvatar(context, ImageSource.gallery);
                        },
                        child: Text(
                          'ReSelect',
                          style: TextStyle(
                            color: constantColors.whiteColor,
                            decoration: TextDecoration.underline,
                            decorationColor: constantColors.whiteColor,
                          ),
                        ),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                constantColors.blueColor),
                          ),
                          onPressed: () {
                            Provider.of<FirebaseOperations>(context,
                                    listen: false)
                                .uploadUserAvatar(context)
                                .whenComplete(() {
                              signInSheet(context);
                            });
                            Navigator.of(ctx).pop();
                          },
                          child: Text(
                            'Confirm Image',
                            style: TextStyle(color: constantColors.whiteColor),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
          );
        });
  }
}
