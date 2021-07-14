import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reachme/screens/LandingPage/landing_utils.dart';
import 'package:reachme/services/Authentication.dart';

class FirebaseOperations with ChangeNotifier {
  UploadTask imageUploadTask;
  String initUserEmail, initUserName, initUserImage;
  Future uploadUserAvatar(BuildContext context) async {
    Reference imageRefrence = FirebaseStorage.instance.ref().child(
        'userProfileAvatar/${Provider.of<LandingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}');
    imageUploadTask = imageRefrence.putFile(
        Provider.of<LandingUtils>(context, listen: false).getUserAvatar);
    await imageUploadTask.whenComplete(() => print('Image uploaded'));
    imageRefrence.getDownloadURL().then((value) {
      Provider.of<LandingUtils>(context, listen: false).userAvatarUrl =
          value.toString();
      print('User profile URL is this: $value.toString()');
      notifyListeners();
    });
  }

  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future initUserData(BuildContext context) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false)
            .getUserUid
            .toString())
        .get()
        .then((doc) {
      print('Fetching Data');
      initUserName = doc.data()['username'];
      initUserEmail = doc.data()['useremail'];
      initUserImage = doc.data()['userimage'];
      print('Username is => $initUserName');
      notifyListeners();
    });
  }
}
