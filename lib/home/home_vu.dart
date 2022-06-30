import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_vm.dart';

class HomeVU extends ViewModelBuilderWidget<HomeVM> {
  HomeVU({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          TextButton(
            onPressed: () {
              viewModel.onLogOutButton(context);
            },
            child: const Text(
              'LogOut',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Home',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  viewModelBuilder(BuildContext context) {
    return HomeVM();
  }
}
