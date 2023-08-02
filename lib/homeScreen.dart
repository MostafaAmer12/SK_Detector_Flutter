import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sk/Constants/ButtonBuilder.dart';
import 'package:sk/Constants/constants.dart';
import 'package:sk/DefaultScreens/uploadScreen.dart';
import 'package:sk/LoginScreens/loginScreen.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'Home Screen';

  String? fName = 'Mostafa';
  String? lName = 'Amer';
  String? email = 'mostafafatouh56@gmail.com';
  String? img = 'assets/logo/logo.png';

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    signOut() async {
      await auth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kPrimaryColor,
      drawer: Drawer(
        backgroundColor: kPrimaryColor,
        elevation: 200,
        child: ListView(padding: EdgeInsets.zero, children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: kGreyColor),
            accountName: Text(
              "$fName $lName",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: kBlackColor,
              ),
            ),
            accountEmail: Text(
              email!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: kBlackColor,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(img!),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: kBlackColor,
            ),
            title: const Text(
              'Log Out',
              style: TextStyle(
                color: kBlackColor,
              ),
            ),
            onTap: () {
              signOut();
            },
          ),
          const AboutListTile(
            icon: Icon(
              Icons.info,
              color: kBlackColor,
            ),
            applicationIcon: Icon(
              Icons.local_hospital_outlined,
            ),
            applicationName: 'SK Detector App',
            applicationVersion: '1.0.25',
            applicationLegalese: '© 2023 Amer',
            aboutBoxChildren: [],
            child: Text(
              'About App',
              style: TextStyle(
                color: kBlackColor,
              ),
            ),
          ),
        ]),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            if (scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.openEndDrawer();
            } else {
              scaffoldKey.currentState!.openDrawer();
            }
          },
          icon: const Icon(
            Icons.menu,
            color: kBlackColor,
          ),
        ),
        title: const Text(
          'SK Detector',
          style: TextStyle(
              color: kBlackColor, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Spacer(flex: 1,),
            Row(
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' $fName,',
                  style: TextStyle(
                    color: kGreenColor.withOpacity(0.7),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            const Text(
              'Want to check for Sickle Cell Anemia?',
              style: TextStyle(
                color: kBlackColor,
                fontSize: 20,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            const Text(
              ' You Came to the right place',
              style: TextStyle(
                color: kBlackColor,
                fontSize: 21,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            const Text(
              'Just press the button below ',
              style: TextStyle(
                color: kBlackColor,
                fontSize: 21,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            const Text(
              'Upload the blood image',
              style: TextStyle(
                color: kBlackColor,
                fontSize: 21,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            const Text(
              'The result appears in fastest way',
              style: TextStyle(
                color: kBlackColor,
                fontSize: 21,
              ),
            ),
            const Spacer(
              flex: 3,
            ),
            ButtonBuilder(
                text: 'Check Now',
                ontap: () {
                  Navigator.pushNamed(context, UploadScreen.id);
                }),
            const Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }
}

