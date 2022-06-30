import 'package:firbase_authentiction/utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'signup_vm.dart';

class SignupVU extends ViewModelBuilderWidget<SignupVM> {
  const SignupVU({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, SignupVM viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('SignUp User'),
        centerTitle: true,
      ),
      body: Form(
        key: viewModel.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(onSaved: (value) => viewModel.onEmail),
              const SizedBox(height: 24),
              TextFormField(
                  obscureText: true, onSaved: (value) => viewModel.onPassword),
              const SizedBox(height: 24),
              elevatedButton(
                  title: 'SignUp',
                  icon: Icons.swipe_up,
                  onPress: () => viewModel.onSignUp(context))
            ],
          ),
        ),
      ),
    );
  }

  @override
  SignupVM viewModelBuilder(BuildContext context) {
    return SignupVM();
  }
}
