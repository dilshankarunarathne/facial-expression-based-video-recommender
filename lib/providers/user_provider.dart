import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:video_filter/auth/sign_in_page.dart';
import 'package:video_filter/screens/home_page.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get userData => _user;

  checkAuthState(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignIn(),
            ));
        Logger().e('User is currently signed out!');
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
        Logger().i('User is signed in!--- ');
      }
    });
  }
}
