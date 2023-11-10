import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:video_filter/auth/sign_in_page.dart';
import 'package:video_filter/controllers/auth_controlller.dart';
import 'package:video_filter/custom-widgets/circular_indicator.dart';

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
<<<<<<< HEAD
              context: context,
              emailAddress: _emailController.text,
              password: _passwordController.text)
          .then((value) {
=======
        emailAddress: _emailController.text,
        password: _passwordController.text,
        context: context,
      ).then((value) {
>>>>>>> 10e1864fc938ca724ad5d09b861d3c1d373b3ed3
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
<<<<<<< HEAD
            timeInSecForIosWeb: 5,
=======
            timeInSecForIosWeb: 3,
>>>>>>> 10e1864fc938ca724ad5d09b861d3c1d373b3ed3
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularIndicator(isVisible: true),
            );
          },
        );
        Future.delayed(
          const Duration(seconds: 4),
          () {
            CircularIndicator(isVisible: false);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignIn(),
                ));
          },
        );
        _recoveryEmailController.text = "";
      });
    }
  }

  Future<void> signInWithGoogle() async {
    final credential = await authController.signInWithGoogle();
  }
}
