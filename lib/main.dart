import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sk/DefaultScreens/splashScreen.dart';
import 'package:sk/LoginScreens/loginScreen.dart';
import 'package:sk/LoginScreens/registerScreen.dart';
import 'package:sk/firebase_options.dart';
import 'package:sk/homeScreen.dart';
import 'DefaultScreens/uploadScreen.dart';
import 'OneTimeScreens/onBoardingScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Sk_Project());
}

class Sk_Project extends StatelessWidget {
  const Sk_Project({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        OnBoardingScreen.id: (context) => const OnBoardingScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        UploadScreen.id: (context) => UploadScreen(),
      },
    );
  }
}
