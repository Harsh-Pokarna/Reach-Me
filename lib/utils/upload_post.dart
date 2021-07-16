import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  UploadTask imagePostUploadTask;
  TextEditingController captionController = TextEditingController();
  Future pickUploadPostImage(BuildContext context, ImageSource source) async {
    final pickedUploadPostImage = await picker.getImage(source: source);
    pickedUploadPostImage == null
        ? print('Select an image')
        : uploadPostImage = File(pickedUploadPostImage.path);
    uploadPostImage != null ? showPostImage(context) : print('Task Failed');
    notifyListeners();
  }

  Future uploadPostToFirebase() async {
    try {
      Reference imageReference = FirebaseStorage.instance
          .ref()
          .child('posts/${uploadPostImage.path}/${TimeOfDay.now()}');
      imagePostUploadTask = imageReference.putFile(uploadPostImage);
      await imagePostUploadTask.whenComplete(() {
        print('post image uploaded');
      });
      imageReference.getDownloadURL().then((value) {
        uploadPostImageUrl = value;
      });
      notifyListeners();
    } catch (error) {
      notifyListeners();
      throw error;
    }
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
                        onPressed: () {
                          pickUploadPostImage(context, ImageSource.gallery);
                        },
                        child: Text('Gallery',
                            style: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 16,
                            ))),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                constantColors.blueColor)),
                        onPressed: () {
                          pickUploadPostImage(context, ImageSource.camera);
                        },
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
            height: 360,
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 200,
                  width: 400,
                  child: Image.file(
                    uploadPostImage,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        onPressed: () async {
                          try {
                            await uploadPostToFirebase();
                            editPostSheet(context);
                          } catch (error) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Something went wrong'),
                                  );
                                });
                          }
                        },
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

  editPostSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
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
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.image_aspect_ratio,
                                  color: constantColors.greenColor,
                                ),
                                onPressed: () {}),
                            IconButton(
                                icon: Icon(
                                  Icons.fit_screen,
                                  color: constantColors.yellowColor,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 300,
                        child: Image.file(
                          uploadPostImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/icons/sunflower.png'),
                      ),
                      Container(
                        height: 110,
                        width: 5,
                        color: constantColors.blueColor,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        height: 120,
                        width: 330,
                        child: TextField(
                          maxLines: 5,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100)
                          ],
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          maxLength: 100,
                          controller: captionController,
                          style: TextStyle(
                            color: constantColors.whiteColor,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                              hintText: 'Caption',
                              hintStyle:
                                  TextStyle(color: constantColors.whiteColor)),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(constantColors.blueColor)),
                  child: Text(
                    'Post',
                    style: TextStyle(
                        color: constantColors.whiteColor, fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
