import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reachme/constants/Constantcolors.dart';
import 'package:reachme/screens/LandingPage/landing_services.dart';

class UploadPost with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  File uploadPostImage;
  File get getUploadPostImage => uploadPostImage;
  String uploadPostImageUrl;
  String get getUploadPostImageUrl => uploadPostImageUrl;
  final picker = ImagePicker();
  Future pickUploadPostImage(BuildContext context, ImageSource source) async {
    final pickedUploadPostImage = await picker.getImage(source: source);
    pickedUploadPostImage == null
        ? print('Select an image')
        : uploadPostImage = File(pickedUploadPostImage.path);
    uploadPostImage != null ? showPostImage(context) : print('Task Failed');
    notifyListeners();
  }

  selectPostImageType(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.circular(12),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                constantColors.blueColor)),
                        onPressed: () {},
                        child: Text('Gallery',
                            style: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 16,
                            ))),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                constantColors.blueColor)),
                        onPressed: () {},
                        child: Text('Camera',
                            style: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 16,
                            ))),
                  ],
                ),
              ],
            ),
          );
        });
  }

  showPostImage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.circular(12),
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
                  backgroundColor: constantColors.transperant,
                  radius: 60,
                  backgroundImage: FileImage(uploadPostImage),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        selectPostImageType(context);
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
                        onPressed: () {},
                        child: Text(
                          'Confirm Image',
                          style: TextStyle(color: constantColors.whiteColor),
                        )),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
