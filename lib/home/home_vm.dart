import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../login/login_vu.dart';
import '../services.dart';
import '../utils.dart';

class HomeVM extends BaseViewModel {
  onLogOutButton(BuildContext context) async {
    await FireBaseServices.logout();
    Utils.pushReplacement(context, const LoginVU());
  }
}
