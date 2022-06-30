import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseServices {
  static FireBaseServices? _instance;
  static FireBaseServices get instance {
    return _instance ??= FireBaseServices();
  }

  FacebookAuth fbAuth = FacebookAuth.i;
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn google = GoogleSignIn();
  GoogleSignInAccount? user;

  static signUpUser(String email, String password, BuildContext context) async {
    try {
      await FireBaseServices.instance.auth
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  static Future<void> loginWithFacebook(BuildContext context) async {
    try {
      LoginResult fbResult = await FireBaseServices.instance.fbAuth.login();
      OAuthCredential credential =
          FacebookAuthProvider.credential(fbResult.accessToken!.token);
      await FireBaseServices.instance.auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  static Future<bool> loginUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
      return false;
    }
  }

  static Future<void> logout() async {
    await FireBaseServices.instance.auth.signOut();
  }

  static googleSignIn() async {
    try {
      final googleUser = await FireBaseServices.instance.google.signIn();
      if (googleUser == null) return;
      FireBaseServices.instance.user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  // static Future<void> googleLogOut() async {
  //   await FireBaseServices.instance.google.disconnect();
  //   FirebaseAuth.instance.signOut();
  // }
}
