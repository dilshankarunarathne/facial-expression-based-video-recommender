import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_filter/auth/forgotpwd_page.dart';
import 'package:video_filter/auth/signup_page.dart';
import 'package:video_filter/providers/signin_provider.dart';

import '../custom-widgets/auth_background.dart';
import '../custom-widgets/custom_button.dart';
import '../custom-widgets/custom_text.dart';
import '../custom-widgets/custom_textfield.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(body: Consumer<SignInProvider>(
        builder: (BuildContext context, value, child) {
          return AuthBackground(
            size: size,
            text1: "Log In",
            content: ListView(
              children: [
                CustomTextField(
                  isPassword: false,
                  label: 'Email',
                  controller: value.emailController,
                  prefix: Icons.email_outlined,
                ),
                CustomTextField(
                  label: "Password",
                  controller: value.passwordController,
                  prefix: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ));
                    },
                    child: CustomPoppinsText(
                        text: "Forgot password?",
                        color: Colors.grey.shade600,
                        fsize: 16,
                        fweight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  size: size,
                  ontap: () {
                    Provider.of<SignInProvider>(context, listen: false)
                        .signInUser();
                  },
                  text: "Log In",
                  buttonColor: Colors.grey.shade900,
                  textColor: Colors.white,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomPoppinsText(
                        text: "Don't have an account?",
                        color: Colors.grey.shade600,
                        fsize: 16,
                        fweight: FontWeight.w500),
                    GestureDetector(
                      child: CustomPoppinsText(
                          text: "Sign Up",
                          color: Colors.grey.shade900,
                          fsize: 16,
                          fweight: FontWeight.bold),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ));
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Expanded(child: Divider(thickness: 2)),
                    CustomPoppinsText(
                        text: "  Or login with  ",
                        color: Colors.grey.shade600,
                        fsize: 16,
                        fweight: FontWeight.w500),
                    const Expanded(child: Divider(thickness: 2)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: size.width * 0.8,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.mail),
                        GestureDetector(
                          child: CustomPoppinsText(
                              text: " Continue with google",
                              color: Colors.black,
                              fsize: 16,
                              fweight: FontWeight.w600),
                          onTap: () {
                            Provider.of<SignInProvider>(context, listen: false)
                                .signInWithGoogle();
                          },
                        )
                      ]),
                )
              ],
            ),
            text2: 'Enter your details below & free log in',
          );
        },
      )),
    );
  }
}
