import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sebbo/checkUser.dart';
import 'package:sebbo/login/loginScreen.dart';
import 'package:sebbo/saveDataLocally/sharedPrefFunctions.dart';
import 'package:sebbo/services/auth_widget.dart';
import '../main.dart';


List<String> myData = [];

class CustomSplashScreen extends StatefulWidget {
  final AsyncSnapshot snapshot;

  CustomSplashScreen({this.snapshot});

  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    getDetail();
    super.initState();
  }

  getDetail() async {
    List<String> data = [];
    String res = await SharedPrefFunction().getLoginPreference();
    if (res == 'true') {
      String number = await SharedPrefFunction().getNumberPreference();
      data = await SharedPrefFunction().getUserData(number);
      print(data.toString() + 'Hello');

    }
    if(this.mounted){
      setState(() {
        isLogin = res;
        if (data != null) {
          print(data.toString() + 'Hello ');
          myData = data;
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    print('Problem is here');
    return SplashScreen.navigate(
      name: 'assets/splash.flr',
      next: (context) {
        splashScreen = false;
        print(isLogin.toString());
        if(isLogin == null){
          return LoginScreen();
        }
        else if(isLogin == 'true'){
            return CheckUser();
        }
        else{
          return AuthWidget(userSnapshot: widget.snapshot,);}
      },
      startAnimation: 'intro',
      until: () => Future.delayed(Duration(seconds: 2)),
      backgroundColor: Colors.white,
    );
  }
}
