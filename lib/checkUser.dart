import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as f_s;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sebbo/constants.dart';
import 'package:sebbo/login/loginScreen.dart';
import 'package:sebbo/saveDataLocally/sharedPrefFunctions.dart';
import 'package:sebbo/screens/home_screen.dart';
import 'package:sebbo/userInfo.dart';
import 'package:sebbo/widgets/custom_app_logo.dart';

import 'package:sebbo/widgets/my_alert_dialog.dart';

import 'loading/progress.dart';
import 'models/userData.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final f_s.Reference storageRef = f_s.FirebaseStorage.instance.ref();

class CheckUser extends StatefulWidget {
  static const String checkRoute = '/login/checkUser';

  @override
  _CheckUserState createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  bool isLoading = true;
  bool dataExists = false;

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  checkUser() async {
    myNumber = await SharedPrefFunction().getNumberPreference();
    DocumentSnapshot doc = await usersRef.doc(myNumber).get();
    if (doc.exists) {
      createUserFromDoc(doc, context);
      setState(() {
        dataExists = true;
        isLoading = false;
      });
    } else {
      setState(() {
        dataExists = false;
        isLoading = false;
      });
    }
  }

  _buildWelcomeBackPage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (dataExists) {
      return WillPopScope(
        onWillPop: () {
          return showDialog(
            context: context,
            builder: (context) => MyAlertDialog(
              message: 'Do you want to exit the app?',
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'No',
                    style: subhead2.copyWith(
                      fontSize: 14,
                      color: themeColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Yes',
                    style: subhead2.copyWith(
                      fontSize: 14,
                      color: themeColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height,
                color: themeColor.withOpacity(0.9),
              ),
              Positioned(
                bottom: -size.width * 0.014 * 60,
                left: size.width * 0.013 * 10,
                child: Material(
                  borderRadius: BorderRadius.circular(size.height / 2),
                  child: Container(
                    width: size.height,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(size.height / 2),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -size.width * 0.014 * 1,
                right: -size.width * 0.014 * 30,
                child: Image.asset(
                  'assets/images/illustration.png',
                  width: size.height * 0.6,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Sebbo',
                      style: appBarTextStyle.copyWith(fontSize: 20),
                    ),
                    Text(
                      'Sell and Buying Books Online',
                      style: subhead1,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: size.width * 0.014 * 10,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Welcome',
                          style: heading1.copyWith(
                              fontSize: 38, color: Colors.white)),
                      Text(
                        'Mate 🙂',
                        style: heading1.copyWith(
                            fontSize: 38, color: Colors.white),
                      ),
                      Text(
                        currentUser.firstName,
                        style: GoogleFonts.raleway(
                            fontSize: 38,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      RaisedButton(
                        elevation: 20,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }));
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          'Let\s Go!',
                          style: TextStyle(fontSize: 18, color: themeColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return WillPopScope(
        onWillPop: () {
          return showDialog(
            context: context,
            builder: (context) => MyAlertDialog(
              message: 'Do you want to exit the app?',
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'No',
                    style: subhead2.copyWith(
                      fontSize: 14,
                      color: themeColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Yes',
                    style: subhead2.copyWith(
                      fontSize: 14,
                      color: themeColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height,
                color: themeColor.withOpacity(0.9),
              ),
              Positioned(
                bottom: -size.width * 0.014 * 60,
                left: size.width * 0.013 * 10,
                child: Material(
                  borderRadius: BorderRadius.circular(size.height / 2),
                  child: Container(
                    width: size.height,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(size.height / 2),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -size.width * 0.014 * 1,
                right: -size.width * 0.014 * 30,
                child: Image.asset(
                  'assets/images/illustration.png',
                  width: size.height * 0.6,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Sebbo',
                      style: appBarTextStyle.copyWith(fontSize: 20),
                    ),
                    Text(
                      'Sell and Buying Books Online',
                      style: subhead1,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: size.width * 0.014 * 10,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Welcome',
                          style: heading1.copyWith(
                              fontSize: 38, color: Colors.white)),
                      Text(
                        'Mate 🙂',
                        style: GoogleFonts.raleway(
                            fontSize: 38,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      RaisedButton(
                        elevation: 20,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return UserInfo(flag: true);
                          }));
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          'Let\s Go!',
                          style: TextStyle(fontSize: 18, color: themeColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? circularProgress() : _buildWelcomeBackPage(context);
  }
}
