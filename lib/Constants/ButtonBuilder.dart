import 'package:flutter/material.dart';
import 'package:sk/Constants/constants.dart';

class ButtonBuilder extends StatelessWidget {
  ButtonBuilder({required this.text, required this.ontap});

  String text;
  VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    bool isUppercase = true;
    return GestureDetector(
      onTap: ontap,
      child: Center(
        child: Container(
          width: screenWidth * 0.44,
          height: screenHeight * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kGreenColor.withOpacity(0.5),
          ),
          child: Center(
            child: Text(
              isUppercase ? text.toUpperCase() : text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: kBlackColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
