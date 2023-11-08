import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_filter/firebase_options.dart';
import 'package:video_filter/providers/signin_provider.dart';
import 'package:video_filter/providers/signup_provider.dart';
import 'package:video_filter/splash%20screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => SignUpProvider(),
        child: const MyApp(),
      ),
      ChangeNotifierProvider(
        create: (context) => SignInProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Video Filter',
        theme: ThemeData(),
        home: const SplashScreen());
  }
}
