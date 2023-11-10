import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:video_filter/auth/sign_in_page.dart';
import 'package:video_filter/controllers/auth_controlller.dart';

class SignInProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _recoveryEmailController =
      TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get recoveryEmailController => _recoveryEmailController;

  AuthController authController = AuthController();

//Sign In user

  Future<void> signInUser(BuildContext context) async {
    if (_emailController.text.isEmpty) {
      Logger().e("Check Your Email");
    } else if (_passwordController.text.isEmpty) {
      Logger().e("Check Your Password");
    } else {
      AuthController.signInUser(
              context: context,
              emailAddress: _emailController.text,
              password: _passwordController.text)
          .then((value) {
        _emailController.text = "";
        _passwordController.text = "";
      });
    }
  }

//Reset Password

  Future<void> sendResetEmail(BuildContext context) async {
    if (_recoveryEmailController.text.isEmpty) {
      Logger().e("Insert Your Email");
    } else {
      AuthController.sendPasswordResetEmail(_recoveryEmailController.text)
          .then((value) {
        Fluttertoast.showToast(
            msg: "Email sent to ${_recoveryEmailController.text}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignIn(),
            ));
        _recoveryEmailController.text = "";
      });
    }
  }

  Future<void> signInWithGoogle() async {
    final credential = await authController.signInWithGoogle();
  }
}
