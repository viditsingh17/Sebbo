import 'package:flutter/material.dart';
import 'package:sebbo/login/loginScreen.dart';
import 'package:sebbo/screens/home_screen.dart';

import 'auth.dart';

/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
/// This widget should be below the [MaterialApp].
/// An [AuthWidgetBuilder] ancestor is required for this widget to work.
class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if(userSnapshot == null){
      return LoginScreen();
    }
    //print(userSnapshot.connectionState.toString() + ' Auth widget');
    else if (userSnapshot.connectionState == ConnectionState.active) {
      print(userSnapshot.hasData.toString() + 'Hello');
      return userSnapshot.hasData ? HomeScreen() : LoginScreen();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
