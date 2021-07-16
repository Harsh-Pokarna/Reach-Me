import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reachme/constants/Constantcolors.dart';
import 'package:reachme/screens/LandingPage/landing_services.dart';
import 'package:reachme/services/firebase_operations.dart';

class LandingUtils with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  final picker = ImagePicker();
  File userAvatar;
  File get getUserAvatar => userAvatar;
  String userAvatarUrl;
  String get getUserAvatarUrl => userAvatarUrl;

  Future pickUserAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar = await picker.getImage(source: source);
    pickedUserAvatar == null
        ? print('Select an image')
        : userAvatar = File(pickedUserAvatar.path);

    userAvatar != null
        ? Provider.of<LandingService>(context, listen: false)
            .showUserAvatar(context)
        : print('Task Failed');
    notifyListeners();
  }

  Future selectAvatarOptionsSheet(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Container(
                    width: 85,
                    child: Divider(
                      thickness: 4,
                      color: constantColors.whiteColor,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          pickUserAvatar(context, ImageSource.gallery)
                              .whenComplete(() {
                            Navigator.pop(ctx);
                            Provider.of<LandingService>(context, listen: false)
                                .showUserAvatar(ctx);
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                constantColors.blueColor)),
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                              color: constantColors.whiteColor, fontSize: 18),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          pickUserAvatar(context, ImageSource.camera)
                              .whenComplete(() {
                            Navigator.pop(ctx);
                            Provider.of<LandingService>(context, listen: false)
                                .showUserAvatar(ctx);
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                constantColors.blueColor)),
                        child: Text(
                          'Camera',
                          style: TextStyle(
                              color: constantColors.whiteColor, fontSize: 18),
                        )),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
