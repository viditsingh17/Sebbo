import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sebbo/saveDataLocally/sharedPrefFunctions.dart';

import '../main.dart';

UserData currentUser;

void createUserFromDoc(doc, context) {
  currentUser = UserData.fromDocument(doc);
  List<String> userData = [
    currentUser.pincode,
    currentUser.firstName,
    currentUser.lastName,
    currentUser.email,
    currentUser.myNumber,
    currentUser.country,
    currentUser.state,
    currentUser.city,
    currentUser._wallet.toString(),
    currentUser.noOfBooks.toString(),
    currentUser.sold.toString()
  ];
  SharedPrefFunction().saveUserData(currentUser.myNumber, userData);
  Provider.of<Data>(context, listen: false).changeMyData(userData);
}

void createUserFromList(doc) {
  currentUser = UserData.fromList(doc);
}

class UserData {
  String firstName;
  String lastName;
  String email;
  String myNumber;
  String state;
  String city;
  String pincode;
  String country;
  String name;
  int _wallet;
  int noOfBooks;
  int sold;

  UserData(
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.myNumber,
      @required this.state,
      @required this.city,
      @required this.pincode,
      @required this.country,
      @required this.noOfBooks,
      this.name,
      @required this.sold}) {
    this.name = this.firstName + this.lastName;
  }

  int getWalletBalance() {
    return _wallet;
  }

  void setWalletBalance(int balance) {
    _wallet = balance;
  }

  factory UserData.fromDocument(DocumentSnapshot doc) {
    var myUser = UserData(
        firstName: doc.get('firstName'),
        lastName: doc.get('lastName'),
        name: doc.get('Name'),
        email: doc.get('email'),
        myNumber: doc.get('mobileNumber'),
        city: doc.get('city'),
        state: doc.get('state'),
        country: doc.get('country'),
        pincode: doc.get('pincode'),
        // _wallet: doc.get('wallet'),
        noOfBooks: doc.get('noOfBooks'),
        sold: doc.get('sold'));
    myUser.setWalletBalance(doc.get('wallet'));
    return myUser;
  }

  factory UserData.fromList(List<String> doc) {
    var myUser = UserData(
        name: doc[1] + ' ' + doc[2],
        firstName: doc[1],
        lastName: doc[2],
        email: doc[3],
        myNumber: doc[4],
        state: doc[6],
        city: doc[7],
        country: doc[5],
        pincode: doc[0],
        // _wallet: int.parse(doc[8]),
        noOfBooks: int.parse(doc[9]),
        sold: int.parse(doc[10]));
    myUser.setWalletBalance(int.parse(doc[8]));
    return myUser;
  }
}
