import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String userUid;
  String get getUserUid => userUid;
  Future logIntoAccount(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((error) {
        print(error);
        throw error;
      });
      User user = userCredential.user;
      userUid = user.uid;
      print('Created Account Uid => $userUid');
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future createAccount(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = userCredential.user;
    userUid = user.uid;
    print('Created Account Uid => $userUid');
    notifyListeners();
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential userCredential =
        await firebaseAuth.signInWithCredential(authCredential);
    final User user = userCredential.user;
    assert(user.uid != null);
    userUid = user.uid;
    print('Google user uid => $userUid');
    notifyListeners();
  }

  Future signOutWithGoogle() async {
    return googleSignIn.signOut();
  }

  Future logOutviaEmail() async {
    return firebaseAuth.signOut();
  }
}
