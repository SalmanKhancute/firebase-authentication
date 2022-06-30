import 'package:firbase_authentiction/home/home_vu.dart';
import 'package:firbase_authentiction/services.dart';
import 'package:firbase_authentiction/utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../sign_in_google/sign_in_google_vu.dart';

class LoginVM extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  onEmail(String value) => email = value;

  onPassword(String value) => password = value;

  onLoginButton(context) async {
    bool isSuccess = await FireBaseServices.loginUser(email, password, context);
    formKey.currentState!.save();
    if (formKey.currentState == null) {
      return;
    }
    if (isSuccess) {
      Utils.pushReplacement(context, HomeVU());
    }

    debugPrint(email);
    debugPrint(password);
  }

  onFbLogin(BuildContext context) async {
    await FireBaseServices.loginWithFacebook(context);
    if (FireBaseServices.instance.auth.currentUser != null) {
      Utils.push(context, HomeVU());
    }
  }

  Future<void> onGoogle(BuildContext context) async {
    await FireBaseServices.googleSignIn();
    notifyListeners();
    Utils.push(context, SignInGoogleVU());
  }
}
