import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sk/Constants/ButtonBuilder.dart';
import 'package:sk/Constants/TextFieldBuilder.dart';
import 'package:sk/Constants/constants.dart';
import 'package:sk/Constants/snackBar.dart';
import 'package:sk/LoginScreens/loginScreen.dart';
import 'package:sk/homeScreen.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'Register Screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? fName;
  String? lName;
  String? email;
  String? phone;
  String? password;
  String? rePassword;
  final firestore =FirebaseFirestore.instance;

  GlobalKey<FormState> formKey = GlobalKey();

  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var phoneController = TextEditingController();

  bool isLoading = false;
  bool showPassword = true;
  bool showRePassword = true;

  @override
  Future<void> registerUser(email, password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    ).then((value) {
      firestore.collection('users').add({
        "FirstName":fName,
        "LastName":lName,
        "Phone":phone,
        "Email":email,
        "Password":password,
      });
    });
  }
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    onpressed() {
      setState(() {
        showPassword = !showPassword;
      });
    }

    onRepressed() {
      setState(() {
        showRePassword = !showRePassword;
      });
    }

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(
                          flex: 3,
                        ),
                        const Center(
                          child: Text(
                            'SK Detector',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: kBlackColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 24,
                              color: kBlackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            TextFieldBuilder(
                              label: 'First Name',
                              onchanged: (data) {
                                fName = data;
                              },
                              controller: fNameController,
                              type: TextInputType.text,
                              width: screenWidth * 0.44,
                            ),
                            SizedBox(
                              width: screenWidth * 0.03,
                            ),
                            TextFieldBuilder(
                              label: 'Last Name',
                              onchanged: (data) {
                                lName = data;
                              },
                              controller: lNameController,
                              type: TextInputType.text,
                              width: screenWidth * 0.44,
                            ),
                          ],
                        ),
                        TextFieldBuilder(
                          label: 'Email',
                          onchanged: (data) {
                            email = data;
                          },
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          width: screenWidth,
                        ),
                        const Spacer(),
                        TextFieldBuilder(
                          label: 'Phone',
                          onchanged: (data) {
                            phone = data;
                          },
                          controller: phoneController,
                          type: TextInputType.phone,
                          width: screenWidth,
                        ),
                        const Spacer(),
                        TextFieldBuilder(
                          label: 'Password',
                          obsecure: showPassword,
                          onchanged: (data) {
                            password = data;
                          },
                          controller: passwordController,
                          suffix: IconButton(
                            onPressed: () {
                              onpressed();
                            },
                            icon: showPassword
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                          type: TextInputType.text,
                          width: screenWidth,
                        ),
                        const Spacer(),
                        TextFieldBuilder(
                          label: 'Re-Password',
                          obsecure: showRePassword,
                          onchanged: (data) {
                            rePassword = data;
                          },
                          controller: rePasswordController,
                          suffix: IconButton(
                            onPressed: () {
                              onRepressed();
                            },
                            icon: showRePassword
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                          type: TextInputType.text,
                          width: screenWidth,
                        ),
                        const Spacer(),
                        Center(
                          child: ButtonBuilder(
                            text: 'Sign Up',
                            ontap: ()
                              async {
                            if (formKey.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                await registerUser(email, password);
                                showSnackBar(context, 'Account created successfully');
                                Navigator.pushNamed(context, HomeScreen.id,
                                    arguments: email);
                              } on FirebaseAuthException catch (e) {
                                print(e);
                                if (e.code == 'weak-password') {
                                  showSnackBar(context, 'Weak password');
                                } else if (e.code == 'email-already-in-use') {
                                  showSnackBar(context, 'Account already exist');
                                }
                              }
                            }
                            isLoading = false;
                            setState(() {});
                          },
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account',
                              style:
                                  TextStyle(color: kBlackColor, fontSize: 15),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, LoginScreen.id);
                                },
                                child: const Text(
                                  'Sign In Now',
                                  style: TextStyle(
                                      color: kGreenColor, fontSize: 15),
                                ))
                          ],
                        ),
                        const Spacer(
                          flex: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
