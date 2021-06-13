import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';
import 'package:sebbo/saveDataLocally/sharedPrefFunctions.dart';
import 'package:sebbo/services/auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sebbo/widgets/custom_header_back.dart';
import '../constants.dart';
import 'loginScreen.dart';

class OtpInput extends StatefulWidget {
  final String number;

  const OtpInput({Key key, this.number}) : super(key: key);

  @override
  _OtpInputState createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  int _start = 30, _current = 30;
  bool codeSent = false;
  String acceptedOtp;

  void startTimer() {
    CountdownTimer countDownTimer = CountdownTimer(
      Duration(seconds: _start),
      Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      if (!mounted) {
        return;
      }
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      //print("Done");
      sub.cancel();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    verify(widget.number);
    startTimer();
    super.initState();
  }

  Future<void> verify(phoneNo) async {
    //phoneNo = countryCode.text + phoneNo;
    myNumber = phoneNo;
    SharedPrefFunction().saveNumberPreference(myNumber);

    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      final auth = Provider.of<AuthBase>(context, listen: false);
      auth.signIn(authResult, context);
    };
    final PhoneVerificationFailed verificationFailed = (authException) {
      //Add dialog to show if any error occurred
      print('Hi  Rapport ${authException.message}');
    };
    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
//      buildOtpInput(context);
      otp = verId;
      setState(() {
        codeSent = true; //In case number is not in the mobile
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      otp = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: Duration(seconds: 30),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final WIDTH = size.width;
    final HEIGHT = size.height;
    final HEIGHT10 = HEIGHT / 53;
    final WIDTH10 = WIDTH / 32;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          CustomHeaderBack(title: 'Verify OTP'),
          Padding(
            padding: EdgeInsets.all(WIDTH > 350 ? 20 : 10),
            child: RichText(
              text: TextSpan(
                  text: 'Waiting to automatically detect sms sent to ',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: '${widget.number}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: 5,
          ),
//            TextField(
//              controller: widget.code,
//              keyboardType: TextInputType.phone,
//              decoration: InputDecoration(
//                isDense: true,
//                contentPadding: EdgeInsets.all(15),
//                enabledBorder: completeInputBorder,
//                focusedBorder: completeInputBorder,
//                hintText: '123456',
//              ),
//            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: PinCodeTextField(
                appContext: context,
                length: 6,
                textStyle: heading2.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black.withOpacity(0.8)),
//                backgroundColor: themeColor.withOpacity(0.5),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 40,
                  fieldWidth: 36,
                  inactiveColor: themeColor,
                  activeColor: themeColor,
//                  activeFillColor:
//                  hasError ? Colors.orange : Colors.white,
                ),
                onChanged: (value) {
                  setState(
                    () {
                      acceptedOtp = value;
                    },
                  );
                }),
          ),

          Padding(
            padding: EdgeInsets.all(WIDTH > 350 ? 20 : 10),
            child: Text(
              'In case you have given a different number. Enter the OTP received there.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            height: 2 * HEIGHT10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: size.width * 0.4,
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: () {
//                final auth =
//                Provider.of<AuthBase>(context, listen: false);
//                print('CodeSent' + codeSent.toString());
//                codeSent
//                    ? auth.signInWithOtp(code.text, otp, context)
//                    : verify(number);
//
                    if (_current == 0) {
                      startTimer();
                      print(_current);
                    }
                    verify(widget.number);
                  },
                  child: Text(
                    _current == 0 ? 'Resend OTP' : 'Resend in($_current)',
                    style: subhead2.copyWith(
                      fontSize: 14,
                      color: _current == 0 ? themeColor : Colors.grey,
                    ),
                  ),
                ),
              ),
              Container(
                width: size.width * 0.4,
                alignment: Alignment.center,
                child: FlatButton(
                  color: themeColor,
                  onPressed: () {
                    final auth = Provider.of<AuthBase>(context, listen: false);
                    print('CodeSent' + codeSent.toString());
                    codeSent
                        ? auth.signInWithOtp(acceptedOtp, otp, context)
                        : verify(widget.number);
                    //Navigator.pop(context);
                  },
                  child: Text(
                    'Verify',
                    style: subhead2.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
