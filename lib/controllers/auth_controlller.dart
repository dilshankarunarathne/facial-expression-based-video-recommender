// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:video_filter/auth/sign_in_page.dart';
import 'package:video_filter/custom-widgets/circular_indicator.dart';
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

  static Future<void> signOutUser(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularIndicator(isVisible: true),
        );
      },
    );
    await FirebaseAuth.instance.signOut();
    CircularIndicator(isVisible: false);
    Fluttertoast.showToast(
          msg: "Signed Out",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade800,
          textColor: Colors.white,
          fontSize: 16.0);
    Logger().i("User logout");
    
  }

  //Sign In to usr account

  static Future<void> signInUser(
      {required String emailAddress,
      required String password,
      required BuildContext context}) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularIndicator(isVisible: true),
        );
      },
    );
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      CircularIndicator(isVisible: false);

      Logger().i("User Signed In");
      Fluttertoast.showToast(
          msg: "Successfully Signed In",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade800,
          textColor: Colors.white,
          fontSize: 16.0);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
          Fluttertoast.showToast(
              msg: "No user found for that email.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(
            msg: "Wrong password provided for that user.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

//create user account using email and password

  Future<void> createUserAccount({
    required String email,
    required String password,
  }) async {
    try {
      CircularIndicator(isVisible: false);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        addUser(value.user!.uid, email);
      });

      Logger().i('Successfully Created Account');
      Fluttertoast.showToast(
          msg: "Successfully Created Account",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade800,
          textColor: Colors.white,
          fontSize: 16.0);
    } on FirebaseAuthException catch (e) {
      CircularIndicator(isVisible: false);
      if (e.code == 'weak-password') {
        Logger().e('The password provided is too weak.');
        Fluttertoast.showToast(
            msg: "The password provided is too weak.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'email-already-in-use') {
        Logger().e('The account already exists for that email.');
        Fluttertoast.showToast(
            msg: "The account already exists for that email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'invalid-email') {
        Logger().e("Invalid Email");
        Fluttertoast.showToast(
            msg: "Invalid Email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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
