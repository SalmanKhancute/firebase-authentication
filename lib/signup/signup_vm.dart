import 'package:firbase_authentiction/login/login_vu.dart';
import 'package:firbase_authentiction/services.dart';
import 'package:firbase_authentiction/utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignupVM extends BaseViewModel {
  String email = '';
  String password = '';
  final formKey = GlobalKey<FormState>();

  onEmail(String value) {
    email = value;
  }

  onPassword(String value) {
    password = value;
  }

  onSignUp(context) async {
    formKey.currentState!.save();
    if (formKey.currentState == null) {
      return;
    }

    await FireBaseServices.signUpUser(email, password, context);

    if (FireBaseServices.instance.auth.currentUser != null) {
      Utils.pushReplacement(context, const LoginVU());
    }
  }
}
