import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sebbo/config/constants.dart';
import 'package:sebbo/loading/progress.dart';
import 'package:sebbo/login/loginScreen.dart';
import 'package:sebbo/main.dart';
import 'package:sebbo/saveDataLocally/sharedPrefFunctions.dart';
import 'package:sebbo/screens/home_screen.dart';
import 'package:sebbo/widgets/my_alert_dialog.dart';
import '../checkUser.dart';
import 'models/userData.dart';

class UserInfo extends StatefulWidget {
  final bool flag;
  UserInfo({this.flag});
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String _firstName;
  String _lastName;
  String _emailId;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //Input form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    widget.flag ? getUserLocation() : editProfile();
    super.initState();
  }

  editProfile() {
    print(currentUser.name);
    firstNameController.text = currentUser.firstName;
    lastNameController.text = currentUser.lastName;
    emailController.text = currentUser.email;
    countryController.text = currentUser.country;
    stateController.text = currentUser.state;
    cityController.text = currentUser.city;
    pincodeController.text = currentUser.pincode;
  }

  Future<void> getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openLocationSettings();
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placeMark = placeMarks[0];
      cityController.text = placeMark.subAdministrativeArea;
      stateController.text = placeMark.administrativeArea;
      pincodeController.text = placeMark.postalCode;
      countryController.text = placeMark.country;
    } catch (e) {
      print(e);
    }
  }

  createFirebase() async {
    setState(() {
      isLoading = true;
    });

    List<String> myData = [
      pincodeController.text,
      _firstName,
      _lastName,
      _emailId,
      myNumber,
      countryController.text,
      stateController.text,
      cityController.text,
      "0",
      "0",
      "0"
    ];
    Provider.of<Data>(context, listen: false).changeMyData(myData);
    createUserFromList(myData);
    DocumentReference docRef = usersRef.doc(myNumber);
    await docRef.set({
      'firstName': _firstName,
      'lastName': _lastName,
      'Name': _firstName + ' ' + _lastName,
      'mobileNumber': myNumber,
      'email': _emailId,
      'country': countryController.text,
      'state': stateController.text,
      'city': cityController.text,
      'pincode': pincodeController.text,
      'wallet': 0,
      'noOfBooks': 0,
      'sold': 0
    });
    SharedPrefFunction().saveUserData(myNumber, myData);
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  }

  saveChanges() async {
    List<String> myData = [
      pincodeController.text,
      firstNameController.text,
      lastNameController.text,
      emailController.text,
      currentUser.myNumber,
      countryController.text,
      stateController.text,
      cityController.text,
      currentUser.getWalletBalance().toString(),
      currentUser.noOfBooks.toString(),
      currentUser.sold.toString()
    ];
    Provider.of<Data>(context, listen: false).changeMyData(myData);
    createUserFromList(myData);
    SharedPrefFunction().saveUserData(currentUser.myNumber, myData);
    usersRef.doc(currentUser.myNumber).update({
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'Name': firstNameController.text + ' ' + lastNameController.text,
      'mobileNumber': currentUser.myNumber,
      'email': emailController.text,
      'country': countryController.text,
      'state': stateController.text,
      'city': cityController.text,
      'pincode': pincodeController.text,
      'wallet': currentUser.getWalletBalance(),
      'noOfBooks': currentUser.noOfBooks,
      'sold': currentUser.sold
    });
    try {
      SnackBar snackBar = SnackBar(
        content: Text('Profile Updated!'),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } catch (e) {
      print(e);
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  }

  Widget _buildFirstName() {
    return myFromField(
      controller: firstNameController,
      label: 'First Name',
      validator: (String value) {
        if (value.isEmpty) {
          return 'First name is required';
        }
        return null;
      },
      onSaved: (String value) {
        _firstName = value;
      },
    );
  }

  Widget _buildLastName() {
    return myFromField(
      controller: lastNameController,
      label: 'Last Name',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last name is required.';
        }
        return null;
      },
      onSaved: (String value) {
        _lastName = value;
      },
    );
  }

  Widget _buildEmail() {
    return myFromField(
      controller: emailController,
      label: 'Email Address',
      hint: 'someone@example.com',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required.';
        }
        if (!RegExp(
                r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')
            .hasMatch(value)) {
          return 'invalid email address';
        }
        return null;
      },
      onSaved: (String value) {
        _emailId = value;
      },
    );
  }

  Widget _buildCountry() {
    return myFromField(
      label: 'Country',
      controller: countryController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Country is required.';
        }

        return null;
      },
    );
  }

  Widget _buildState() {
    return myFromField(
      label: 'State',
      controller: stateController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'State is required.';
        }

        return null;
      },
    );
  }

  Widget _buildCity() {
    return myFromField(
      label: 'City',
      controller: cityController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'City is required.';
        }

        return null;
      },
    );
  }

  Widget _buildPincode() {
    return myFromField(
      label: 'PIN Code',
      controller: pincodeController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'PIN code is required.';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? circularProgress()
        : WillPopScope(
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
              key: _scaffoldKey,
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    widget.flag
                        ? Navigator.pushReplacementNamed(
                            context,
                            CheckUser.checkRoute,
                          )
                        : Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }));
                  },
                ),
                title: Text(
                  widget.flag ? 'User Profile' : 'Edit Profile',
                  style: appBarTextStyle,
                ),
                backgroundColor: Colors.white,
                elevation: 5,
              ),
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: _buildFirstName(),
                          ),
                          Expanded(
                            child: _buildLastName(),
                          ),
                        ],
                      ),
                      /*


                      Gender and DOB will Come here.


                       */
                      _buildEmail(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: _buildCountry(),
                          ),
                          Expanded(child: _buildState()),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: _buildCity(),
                          ),
                          Expanded(
                            child: _buildPincode(),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () {
                          getUserLocation();
                        },
                        icon: Icon(
                          Icons.my_location,
                          color: Colors.blue,
                        ),
                        label: Text(
                          'Use current Location',
                          style: subhead2,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      myRaisedButton(
                        label: widget.flag ? 'Next' : 'Save Changes',
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          print(_firstName + " " + _lastName);
                          print(_emailId);
                          if (!isLoading) {
                            widget.flag ? createFirebase() : saveChanges();
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
