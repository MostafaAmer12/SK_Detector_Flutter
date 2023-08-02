import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sk/OneTimeScreens/onBoardingScreen.dart';

import '../Constants/constants.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'Splash Screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, OnBoardingScreen.id);
    });
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        height: size.height,
        width: size.width,
        color: kPrimaryColor,
        child: Column(
          children: [
            SizedBox(
              height: size.height / 3,
            ),
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: size.height / 4,
                width: size.width / 2,
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: kPrimaryColor,
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/logo/logo.png",
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            SizedBox(
              height: size.height / 7,
            ),
            Container(
              height: size.height / 20,
              width: size.width / 10,
              child: const CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: kGreenColor,
              ),
            ),
            SizedBox(
              height: size.height / 60,
            ),
            Container(
              alignment: Alignment.center,
              height: size.height / 15,
              width: size.width / 1.15,
              child: const Text(
                'Please Wait...',
                style: TextStyle(
                  fontSize: 18,
                  color: kBlackColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
