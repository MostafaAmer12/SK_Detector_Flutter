import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sk/Constants/ButtonBuilder.dart';
import 'package:sk/Constants/TextFieldBuilder.dart';
import 'package:sk/Constants/constants.dart';
import 'package:sk/Constants/snackBar.dart';
import 'package:sk/LoginScreens/registerScreen.dart';
import 'package:sk/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isLoading = false;
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    onpressed() {
      setState(() {
        showPassword = !showPassword;
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
                          flex: 7,
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
                        const Spacer(
                          flex: 2,
                        ),
                        const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 24,
                              color: kBlackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
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
                        Center(
                          child: ButtonBuilder(
                            text: 'Sign In',
                            ontap: ()
                              // Navigator.pushNamed(context, HomeScreen.id);
                              async{
                                if (formKey.currentState!.validate()) {
                                  isLoading = true;
                                  setState(() {});
                                  try {
                                    await loginUser(email, password);
                                    showSnackBar(context, 'Signed in successfully');
                                    Navigator.pushNamed(context, HomeScreen.id,
                                        arguments: email);
                                  } on FirebaseAuthException catch (e) {
                                    print(e);
                                    if (e.code == 'user-not-found') {
                                      showSnackBar(context, 'User not found');
                                    } else if (e.code == 'wrong-password') {
                                      showSnackBar(context, 'Wrong password');
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
                              'Don\'t have an account',
                              style:
                                  TextStyle(color: kBlackColor, fontSize: 15),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RegisterScreen.id);
                                },
                                child: const Text(
                                  'Sign Up Now',
                                  style: TextStyle(
                                      color: kGreenColor, fontSize: 15),
                                ))
                          ],
                        ),
                        const Spacer(
                          flex: 12,
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
Future<void> loginUser(email, password) async {
  UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email!,
    password: password!,
  );
}
// Future<void> userInfo (phone,fname,lname)async{
//   DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");
//
//   await ref.set({
//     "name": "John",
//     "age": 18,
//     "address": {
//       "line1": "100 Mountain View"
//     }
//   });
// }