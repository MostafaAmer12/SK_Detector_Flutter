import 'package:flutter/material.dart';
import 'package:sk/Constants/constants.dart';

class TextFieldBuilder extends StatelessWidget {
  TextFieldBuilder({
    required this.label,
    required this.onchanged,
    required this.controller,
    required this.type,
    required this.width,
    this.suffix,
    this.onpressed,
    this.obsecure = false,
  });

  String label;
  Function(String)? onchanged;
  bool? obsecure;
  Function? onpressed;
  Widget? suffix;
  TextEditingController? controller;
  TextInputType? type;
  double? width;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: screenHeight * 0.09,
      child: TextFormField(
        controller: controller,
        obscureText: obsecure!,
        style: const TextStyle(
          color: kBlackColor,
        ),
        validator: (data) {
          if (data!.isEmpty) {
            return 'Field is required';
          }
        },
        onChanged: onchanged,
        keyboardType: type,
        decoration: InputDecoration(
          suffixIcon: suffix,
          hintText: label,
          hintStyle: const TextStyle(
            color: kBlackColor,
          ),
        ),
      ),
    );
  }
}
