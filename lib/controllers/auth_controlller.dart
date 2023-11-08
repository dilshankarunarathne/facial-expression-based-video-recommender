import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:video_filter/auth/sign_in_page.dart';
import 'package:video_filter/screens/home_page.dart';

class AuthController {
  //Check auth state

  static Future<void> checkAuthState(BuildContext context) async {
    Future.delayed(
        const Duration(
          seconds: 5,
        ), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignIn(),
              ));
          print('User is currently signed out!');
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
          print('User is signed in!');
        }
      });
    });
  }

  //Sign out user

  static Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
    Logger().i("User logout");
  }

  //Sign In to usr account

  static Future<void> signInUser(
      {required String emailAddress, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      Logger().i(credential.user!.uid);
      Logger().i("User Signed In");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

//create user account using email and password

  Future<void> createUserAccount({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        addUser(value.user!.uid, email);
      });

      Logger().i(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Logger().e('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        Logger().e("Invalid Email");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

//Password Reset
  static Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  //save user data

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(String uid, String email) {
    return users
        .doc(uid)
        .set({'uid': uid, 'email': email})
        .then((value) => Logger().i("User added"))
        .catchError((e) => Logger().e(e));
  }

  //Google Authentication

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
