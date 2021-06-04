import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sebbo/saveDataLocally/sharedPrefFunctions.dart';
import 'package:sebbo/widgets/platform_alert_dialog.dart';

import '../main.dart';


class User {
  User({@required this.number});
  final String number;
}
abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<void> signInWithOtp(String smsCode, String verId, BuildContext context);
  Future<User> signIn(auth.AuthCredential authCredential,BuildContext context);
  Future<void> signOut();
}

class Auth implements AuthBase{
  final _firebaseAuth = auth.FirebaseAuth.instance;

  User _userFromFirebase(auth.User user) {
    if(user == null){
      return null;
    }
    isLogin = 'true';
    return User(number: user.phoneNumber);
  }
  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }
  @override
  Future<User> currentUser() async {
    final user =  _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }
  @override
  Future<void> signInWithOtp(smsCode, verId, context) async{
    try{
      auth.AuthCredential authCredential = auth.PhoneAuthProvider.credential(
          verificationId: verId, smsCode: smsCode);
      signIn(authCredential,context);}on PlatformException catch (e){
      PlatformExceptionAlertDialog(
        title: 'Signing In Failed',
        exception: e,
      ).show(context);
    }
  }
  @override
  // ignore: missing_return
  Future<User> signIn(auth.AuthCredential authCredential,BuildContext context) async{
    final authRes = await auth.FirebaseAuth.instance.signInWithCredential(authCredential).catchError((e){PlatformExceptionAlertDialog(
      title: 'Signing In Failed',
      exception: e,
    ).show(context);});
    return _userFromFirebase(authRes.user);
  }
  @override
  Future<void> signOut() async{
    SharedPrefFunction().deleteCache();
    isLogin = 'false';
    await auth.FirebaseAuth.instance.signOut();
  }
}