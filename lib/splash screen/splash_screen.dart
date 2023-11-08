import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_filter/controllers/auth_controlller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthController.checkAuthState(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/assets/download.png",
                  width: size.width * 0.5,
                  height: size.height * 0.5,
                ),
              ],
            ),
          ),
          const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: CupertinoActivityIndicator(
                  radius: 15,
                ),
              ))
        ],
      ),
    );
  }
}
