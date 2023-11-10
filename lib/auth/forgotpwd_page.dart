import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_filter/auth/sign_in_page.dart';
import 'package:video_filter/providers/signin_provider.dart';

import '../custom-widgets/auth_background.dart';
import '../custom-widgets/custom_button.dart';
import '../custom-widgets/custom_textfield.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final TextEditingController resetPwdController = TextEditingController();

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
            content: ListView(
              children: [
                CustomTextField(
                    label: "Email",
                    controller: Provider.of<SignInProvider>(context)
                        .recoveryEmailController,
                    prefix: Icons.mail_outline),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  size: size,
                  ontap: () {
                    Provider.of<SignInProvider>(context, listen: false)
                        .sendResetEmail(context);
                  },
                  text: "Reset password",
                  buttonColor: Colors.grey.shade900,
                  textColor: Colors.white,
                )
              ],
            ),
            text1: "Reset your password",
            text2: 'Enter your details below & reset password',
          ),
        ),
      ),
    );
  }
}
