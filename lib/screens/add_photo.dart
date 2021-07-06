import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sebbo/checkUser.dart';
import 'package:sebbo/imageHandler/imageHandler.dart';
import 'package:sebbo/loading/progress.dart';
import 'package:sebbo/models/userData.dart';
import 'package:sebbo/saveDataLocally/sharedPrefFunctions.dart';

import '../constants.dart';

final bookRef = FirebaseFirestore.instance.collection('books');

class UploadBooks extends StatefulWidget {

  @override
  _UploadBooksState createState() => _UploadBooksState();

/*
  This screen is only shown in case of Home tutor
   */
}

class _UploadBooksState extends State<UploadBooks> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name,author;
  int mrp;
  PickedFile first, second, third, fourth, fifth;
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();


  handleTakePhoto(String title) async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    PickedFile file = await _picker.getImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      if(title == 'first'){
        this.first = file;
      }
      else if(title == 'second'){
        this.second = file;
      }
      else if(title == 'third'){
        this.third = file;
      }
      else if(title == 'fourth'){
        this.fourth = file;
      }
      else if(title == 'fifth'){
        this.fifth = file;
      }
    });
  }

  handleChooseFromGallery(String title) async {
    Navigator.pop(context);
    PickedFile file =
    await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(title == 'first'){
        this.first = file;
      }
      else if(title == 'second'){
        this.second = file;
      }
      else if(title == 'third'){
        this.third = file;
      }
      else if(title == 'fourth'){
        this.fourth = file;
      }
      else if(title == 'fifth'){
        this.fifth = file;
      }
    });
  }

  selectImage(parentContext, String title) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          elevation: 50,
          backgroundColor: Colors.white,
          //contentPadding: EdgeInsets.all(20.0),
          titlePadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: Text(
              'Add Picture',
              style: heading2,
            ),
          ),
          children: <Widget>[
            SimpleDialogOption(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.camera_alt,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'From Camera',
                    style: subhead2,
                  ),
                ],
              ),
              onPressed: () {
                handleTakePhoto(title);
              },
            ),
            SimpleDialogOption(
              onPressed: () {
                handleChooseFromGallery(title);
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.image,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'From Gallery',
                    style: subhead2,
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              alignment: Alignment.center,
              child: GestureDetector(
                child: Text(
                  'Cancel',
                  style: subhead2.copyWith(
                    fontSize: 14,
                    color: themeColor,
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        );
      },
    );
  }

  createFirebase() async {
    String firstUrl = ' ';
    String secondUrl = ' ';
    String thirdUrl = ' ';
    String fourthUrl = ' ';
    String fifthUrl = ' ';
    setState(() {
      isLoading = true;
    });
    if (first != null) {
      firstUrl =
      await ImageHandler().handleImage(first,name, 'first', currentUser.myNumber);
    
    if (second != null) {
      secondUrl =
      await ImageHandler().handleImage(second,name, 'second', currentUser.myNumber);
    }
    if (third != null) {
      secondUrl =
      await ImageHandler().handleImage(third,name, 'third', currentUser.myNumber);
    }
    if (fourth != null) {
      secondUrl =
      await ImageHandler().handleImage(fourth,name, 'fourth', currentUser.myNumber);
    }
    if (fifth != null) {
      secondUrl =
      await ImageHandler().handleImage(fifth,name, 'fifth', currentUser.myNumber);
    }
  }

    DocumentReference docRef =
    bookRef.doc(currentUser.myNumber).collection('books').doc(name);
    await docRef.set({
      'name': name,
      'author':author,
      'first': firstUrl,
      'second': secondUrl,
      'third':thirdUrl,
      'fourth':fourthUrl,
      'fifth':fifthUrl
    });
    usersRef
        .doc(currentUser.myNumber)
        .update({'noOfBooks': currentUser.noOfBooks + 1});
    List<String> myData = [
      currentUser.pincode,
      currentUser.firstName,
      currentUser.lastName,
      currentUser.email,
      currentUser.myNumber,
      currentUser.country,
      currentUser.state,
      currentUser.city,
      currentUser.wallet.toString(),
      (currentUser.noOfBooks +1).toString(),
      currentUser.sold.toString()
    ];
    createUserFromList(myData);
    SharedPrefFunction().saveUserData(currentUser.myNumber, myData);
    Navigator.of(context).pop();
    setState(() {
      isLoading = false;
    });
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
      child: TextFormField(
        keyboardType: TextInputType.name,
        decoration: myInputDecoration(label: 'Name'),
        validator: (String value) {
          if (value.isEmpty) return 'Book name is  required';
          return null;
        },
        onSaved: (String value) {
          name = value;
        },
      ),
    );

  }


  Widget _buildMRP() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: myInputDecoration(label: 'MRP'),
        validator: (String value) {
          if (value.isEmpty) return 'MRP is  required';
          return null;
        },
        onSaved: (String value) {
          mrp = int.tryParse(value);
        },
      ),
    );

  }

  Widget _buildAadharImage() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add front part of the book',
              style: subhead2.copyWith(fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectImage(context, 'first');
            },
            child: Container(
              padding: const EdgeInsets.all(8.9),
              height: MediaQuery.of(context).size.height * 0.28,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black38)),
              child: first != null

                  ? Image(image: FileImage(File(first.path)),)
                  : Image.asset(
                'assets/images/aadhar_placeholder_first.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add image of your Aadhar Card\'s second',
              style: subhead2.copyWith(fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectImage(context, 'second');
            },
            child: Container(
              padding: const EdgeInsets.all(8.9),
              height: MediaQuery.of(context).size.height * 0.28,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black38)),
              child: second != null
                  ? Image(image: FileImage(File(second.path)))
                  : Image.asset(
                'assets/images/aadhar_placeholder_second.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? circularProgress()
        : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        centerTitle: true,
        title: Text(
          'Verification',
          style: appBarTextStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.center,
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'As per our policy you need to verify yourself by providing your Aadhar card details. Read here',
                  style: subhead2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _buildName(),
              _buildMRP(),
              _buildAadharImage(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Rapport will never share your Aadhar card details to any of its users or third party platforms.',
                  style: subhead2.copyWith(color: Colors.redAccent),
                ),
              ),

              //-------End of form-------
              SizedBox(
                height: 30,
              ),
              myRaisedButton(
                label: 'Next',
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  createFirebase();
                },
              ),
            ],
          ),
        ),

      ),
    );
  }
}
