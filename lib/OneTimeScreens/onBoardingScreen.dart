import 'package:flutter/material.dart';
import 'package:sk/Constants/ButtonBuilder.dart';
import 'package:sk/Constants/constants.dart';
import 'package:sk/LoginScreens/registerScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static String id = 'OnBoarding Screen';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    initState() {
      super.initState();
    }

    List<BoardModel> list;
    var isLast = false;
    final controller = PageController();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    list = [
      BoardModel(
        'assets/logo/logo.png',
        'Welcome to SK Detector',
        'We are pleased to join Us',
      ),
      BoardModel(
        'assets/logo/logo.png',
        'Our aim is to keep you health',
        '',
      ),
    ];
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            PageView.builder(
              physics: const BouncingScrollPhysics(),
              onPageChanged: (i) {
                if (i == list.length - 1 && !isLast) {
                  setState(() => isLast = true);
                } else if (isLast) {
                  setState(() => isLast = false);
                }
              },
              controller: controller,
              itemCount: list.length,
              itemBuilder: (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: screenHeight * 0.08,
                  ),
                  Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.37,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          list[index].image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.08,
                  ),
                  Text(
                    list[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: screenHeight <= 660 ? 18 : 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    list[index].body,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kBlackColor.withOpacity(0.85),
                      fontSize: screenHeight <= 660 ? 18 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.82,
              left: screenWidth * 0.43,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    effect: WormEffect(
                      dotColor: kBlackColor.withOpacity(0.8),
                      activeDotColor: kDGreenColor.withOpacity(0.9),
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: list.length,
                  ),
                ],
              ),
            ),
                Positioned(
                  top: screenHeight * 0.87,
                  left: screenWidth * 0.25,
                  child: ButtonBuilder(
                    text: 'Sign Up Now',
                    ontap: () {
                      Navigator.pushNamed(context, RegisterScreen.id);
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class BoardModel {
  String image;
  String title;
  String body;

  BoardModel(this.image, this.title, this.body);
}
