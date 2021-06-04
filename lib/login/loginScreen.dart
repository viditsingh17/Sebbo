import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sebbo/login/otp_input.dart';
import 'package:sebbo/widgets/my_alert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

String number, otp;
String myNumber = ' ';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
  static const String loginRoute = '/onboarding/login';
}

class _LoginScreenState extends State<LoginScreen> {
  String otp, smsCode;
  TextEditingController code = TextEditingController();
  TextEditingController countryCode = TextEditingController();

  //Are terms and conditions checked?
  bool isTCChecked = false;

  // bool codeSent = false;
  Image logo;

  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    countryCode.text = '+91';
  }

  @override
  Widget build(BuildContext context) {
//    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => MyAlertDialog(
              message: 'Do you want to exit the App',
              actions: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Text("NO"),
                ),
                //SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(true),
                  child: Text("YES"),
                ),
              ],
            ));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _loginKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Positioned(
                    top: -size.width / 6,
                    left: -size.width / 6,
                    child: Transform.rotate(
                      angle: pi / 4,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: size.height,
                          height: size.width,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -size.width * 0.8,
                    left: -size.width / 6,
                    child: Transform.rotate(
                      angle: pi * 0.95,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: size.height,
                          height: size.width,
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -size.width / 10,
                    child: Transform.rotate(
                      angle: pi / 3,
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 3,
                        child: Container(
                          width: size.height / 2,
                          height: size.width / 1.6,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: size.height - MediaQuery.of(context).padding.top,
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
//                      SizedBox(
//                        height: size.height / 9,
//                      ),
                        Row(
                          children: <Widget>[
                            Card(
                              child: Image.asset(
                                "assets/images/logo_blue.png",
                                height: size.width > 350 ? 54 : 44,
                                fit: BoxFit.cover,
                              ),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.014 * 2,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Rapport',
                                  style: appBarTextStyle.copyWith(
                                      fontSize: size.width > 350 ? 28 : 22,
                                      color: Colors.black.withOpacity(0.9)),
                                ),
                                Text(
                                  'Success ahead',
                                  style: subhead2.copyWith(
                                      fontSize: size.width > 350 ? 16 : 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Login',
                          style: GoogleFonts.montserrat(
                            fontSize: size.width > 350 ? 32 : 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Welcome',
                          style: GoogleFonts.raleway(
                            fontSize: size.width > 350 ? 24 : 20,
                            fontWeight: FontWeight.w300,
                          ),
//                      style: TextStyle(
//                        fontSize: 24,
//                        fontFamily: 'Montserrat',
//                        fontWeight: FontWeight.w300,
//                      ),
                        ),
                        const Text(
                          'Sign in to continue with your mobile number.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: size.width,
                          margin: EdgeInsets.all(5),
                          child: _buildInput(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Rapport will send a 6 digit OTP via SMS to verify your phone number.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Checkbox(
                            value: isTCChecked,
                            onChanged: (value) {
                              setState(() {
                                isTCChecked = value;
                              });
                            },
                            activeColor: themeColor,
                          ),
                          title: RichText(
                            text: TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: "Terms & conditions",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: themeColor,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async{
                                        if (await canLaunch(
                                            'http://privacy-html.stackstaging.com/1_2_terms-conditions.html')) {
                                          await launch('http://privacy-html.stackstaging.com/1_2_terms-conditions.html');
                                        }
                                      },
                                  ),
                                  TextSpan(
                                    text: " and the ",
                                  ),
                                  TextSpan(
                                    text: "Privacy policy",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: themeColor,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async{
                                        if (await canLaunch(
                                            'http://privacy-html.stackstaging.com')) {
                                          await launch('http://privacy-html.stackstaging.com');
                                        }
                                      },
                                  ),
                                  TextSpan(
                                    text: ".",
                                  ),
                                ]),
                          ),
                        ),
                        myRaisedButton(
                          label: 'Get OTP',
                          onPressed: () {
                            if (!_loginKey.currentState.validate()) {
                              return;
                            }
                            if (!isTCChecked) {
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      title: Text('Terms and conditions'),
                                      content: Text(
                                        "Please accept the terms and conditions first.",
                                        style: subhead2.copyWith(
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text(
                                            'Okay',
                                            style: subhead2.copyWith(
                                              fontSize: 14,
                                              color: themeColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                              return;
                            }
                            _loginKey.currentState.save();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return OtpInput(
                                    number: (countryCode.text + number),
                                  );
                                },
                              ),
                            );
                            // verify(number);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Code to verify number

  Widget _buildInput() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              //controller: TextEditingController()..text = '+91',
              controller: countryCode,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(15),
                enabledBorder: completeInputBorder,
                focusedBorder: completeInputBorder,
                errorBorder: completeInputBorder,
                labelText: 'Code',
                labelStyle: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(15),
                enabledBorder: completeInputBorder,
                focusedBorder: completeInputBorder,
                errorBorder: completeInputBorder,
                labelText: 'Mobile Number',
                labelStyle: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w600),
              ),
              onSaved: (value) {
                number = value;
              },
              validator: (value) {
                if (value.length != 10) {
                  return 'Invalid mobile number.';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
