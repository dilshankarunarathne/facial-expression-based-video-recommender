import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_filter/auth/sign_in_page.dart';
import 'package:video_filter/custom-widgets/auth_background.dart';
import 'package:video_filter/providers/signup_provider.dart';

import '../custom-widgets/custom_button.dart';
import '../custom-widgets/custom_textfield.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignIn(),
            ));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: AuthBackground(
              size: size,
              content: ListView(children: [
                CustomTextField(
                  label: 'Email',
                  controller:
                      Provider.of<SignUpProvider>(context).emailController,
                  prefix: Icons.email_outlined,
                ),
                CustomTextField(
                  isPassword: true,
                  label: 'Password',
                  controller:
                      Provider.of<SignUpProvider>(context).passwordController,
                  prefix: Icons.lock_outline,
                ),
                CustomTextField(
                  isPassword: true,
                  label: 'Confirm password',
                  controller: Provider.of<SignUpProvider>(context)
                      .confirmPasswordController,
                  prefix: Icons.lock_outline,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  size: size,
                  ontap: () {
                    Provider.of<SignUpProvider>(context, listen: false)
                        .signUpUser();
                  },
                  text: 'Create account',
                  buttonColor: Colors.grey.shade900,
                  textColor: Colors.white,
                )
              ]),
              text1: "Sign Up",
              text2: 'Enter your details below & free sign up'),
        ),
      ),
    );
  }
}
