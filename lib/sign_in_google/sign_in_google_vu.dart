import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/home_vm.dart';

class SignInGoogleVU extends StatelessWidget {
  SignInGoogleVU({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;
  HomeVM vm = HomeVM();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Google Display'),
        actions: [
          TextButton(
            child: const Text(
              'LogOut',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              vm.onLogOutButton(context);
            },
          )
        ],
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Profile ',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user!.photoURL ??
                    "https://play-lh.googleusercontent.com/_BmTvgHqlj1Ai8ZAPTc00x4jn19vfXUFlNYWScBvoPu7obzf6NcCtfPq0skGfRKtgts")),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Name: ' + user!.displayName!,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Email: ' + user!.email!,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
