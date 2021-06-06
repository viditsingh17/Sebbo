import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:sebbo/saveDataLocally/sharedPrefFunctions.dart';

import '../main.dart';
UserData currentUser;

void createUserFromDoc(doc,context){
  currentUser = UserData.fromDocument(doc);
  List<String> userData = [currentUser.pincode,currentUser.firstName,currentUser.lastName,currentUser.email,currentUser.myNumber,currentUser.country,currentUser.state,currentUser.city];
  SharedPrefFunction().saveUserData(currentUser.myNumber, userData);
  Provider.of<Data>(context,listen: false).changeMyData(userData);
}
void createUserFromList(doc) {
  currentUser = UserData.fromList(doc);
}

class UserData {

  final String firstName;
  final String lastName;
  final String email;
  final String myNumber;
  final String state;
  final String city;
  final String pincode;
  final String country;
  final String name;

  UserData({
    this.firstName,
    this.lastName,
    this.email,
    this.myNumber,
    this.state,
    this.city,
    this.pincode,
    this.country,
    this.name,
  });

  factory UserData.fromDocument(DocumentSnapshot doc){
    
    return UserData(
        firstName: doc.get('firstName'),
        lastName: doc.get('lastName'),
        name: doc.get('Name'),
        email: doc.get('email'),
        myNumber: doc.get('mobileNumber'),
        city: doc.get('city'),
        state: doc.get('state'),
        country: doc.get('country'),
        pincode: doc.get('pincode')
    );
  }

  factory UserData.fromList(List<String> doc){
    return UserData(
      name: doc[1]+' '+doc[2],
      firstName: doc[1],
      lastName: doc[2],
      email: doc[3],
      myNumber: doc[4],
      state: doc[6],
      city: doc[7],
      country: doc[5],
      pincode: doc[0]
    );
  }

}