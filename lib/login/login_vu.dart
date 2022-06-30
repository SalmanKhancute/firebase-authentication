import 'package:firbase_authentiction/signup/signup_vu.dart';
import 'package:firbase_authentiction/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

import 'login_vm.dart';

class LoginVU extends ViewModelBuilderWidget<LoginVM> {
  const LoginVU({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, LoginVM viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Login User'),
        centerTitle: true,
      ),
      body: Form(
        key: viewModel.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(onSaved: (value) => viewModel.onEmail),
              const SizedBox(height: 24),
              TextFormField(
                  obscureText: true, onSaved: (value) => viewModel.onPassword),
              const SizedBox(height: 24),
              elevatedButton(
                  title: 'login',
                  icon: Icons.login_sharp,
                  onPress: () => viewModel.onLoginButton(context)),
              elevatedButton(
                  title: 'Facebook',
                  icon: FontAwesomeIcons.facebook,
                  onPress: () => viewModel.onFbLogin(context)),
              elevatedButton(
                  title: 'Google',
                  icon: FontAwesomeIcons.google,
                  onPress: () => viewModel.onGoogle(context)),
              elevatedButton(
                  title: 'SignUp',
                  icon: Icons.swipe_up,
                  onPress: () =>
                      Utils.pushReplacement(context, const SignupVU())),
            ],
          ),
        ),
      ),
    );
  }

  @override
  LoginVM viewModelBuilder(BuildContext context) {
    return LoginVM();
  }
}
