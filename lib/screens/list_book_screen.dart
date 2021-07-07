import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sebbo/checkUser.dart';
import 'package:sebbo/config/constants.dart';
import 'package:sebbo/imageHandler/imageHandler.dart';
import 'package:sebbo/loading/progress.dart';
import 'package:sebbo/models/userData.dart';
import 'package:sebbo/saveDataLocally/sharedPrefFunctions.dart';
import 'package:sebbo/widgets/custom_header_back.dart';

final bookRef = FirebaseFirestore.instance.collection('books');

class ListBook extends StatefulWidget {
  static const String listRoute = '/home/listbook';

  @override
  _ListBookState createState() => _ListBookState();
}

class _ListBookState extends State<ListBook> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name, author;
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
      if (title == 'first') {
        this.first = file;
      } else if (title == 'second') {
        this.second = file;
      } else if (title == 'third') {
        this.third = file;
      } else if (title == 'fourth') {
        this.fourth = file;
      } else if (title == 'fifth') {
        this.fifth = file;
      }
    });
  }

  handleChooseFromGallery(String title) async {
    Navigator.pop(context);
    PickedFile file = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (title == 'first') {
        this.first = file;
      } else if (title == 'second') {
        this.second = file;
      } else if (title == 'third') {
        this.third = file;
      } else if (title == 'fourth') {
        this.fourth = file;
      } else if (title == 'fifth') {
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
      firstUrl = await ImageHandler()
          .handleImage(first, name, 'first', currentUser.myNumber);

      if (second != null) {
        secondUrl = await ImageHandler()
            .handleImage(second, name, 'second', currentUser.myNumber);
      }
      if (third != null) {
        secondUrl = await ImageHandler()
            .handleImage(third, name, 'third', currentUser.myNumber);
      }
      if (fourth != null) {
        secondUrl = await ImageHandler()
            .handleImage(fourth, name, 'fourth', currentUser.myNumber);
      }
      if (fifth != null) {
        secondUrl = await ImageHandler()
            .handleImage(fifth, name, 'fifth', currentUser.myNumber);
      }
    }

    DocumentReference docRef =
        bookRef.doc(currentUser.myNumber).collection('books').doc(name);
    await docRef.set({
      'name': name,
      'author': author,
      'first': firstUrl,
      'second': secondUrl,
      'third': thirdUrl,
      'fourth': fourthUrl,
      'fifth': fifthUrl
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
      currentUser.getWalletBalance().toString(),
      (currentUser.noOfBooks + 1).toString(),
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

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
      child: TextFormField(
        keyboardType: TextInputType.name,
        decoration: myInputDecoration(
          // label: 'Description',
          hint:
              'Description : Add details of the author, when the book was published, what is it about, how much does it cost etc.',
        ),
        maxLines: 5,
        validator: (String value) {
          if (value.isEmpty) return 'Book description is  required';
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
        decoration: myInputDecoration(
          label: 'MRP',
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
            child: Text(
              '\u20B9',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
        ),
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

  Widget _buildImageStack({var imageObject, String placeholderPath}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(8.9),
          height: MediaQuery.of(context).size.height * 0.28,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black38)),
          child: imageObject != null
              ? Image(
                  image: FileImage(File(imageObject.path)),
                )
              : Image.asset(
                  placeholderPath,
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          bottom: -10,
          right: -10,
          child: Container(
            height: 60,
            width: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: imageObject == null ? Colors.blue[300] : Colors.green[400],
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              imageObject == null ? Icons.add_outlined : Icons.check_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookImage() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // First page
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add front page of the book',
              style: subhead2.copyWith(fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectImage(context, 'first');
            },
            child: _buildImageStack(
                imageObject: first,
                placeholderPath: 'assets/images/placeholders/1.png'),
          ),
          // Second page
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add last page of the book',
              style: subhead2.copyWith(fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectImage(context, 'second');
            },
            child: _buildImageStack(
                imageObject: second,
                placeholderPath: 'assets/images/placeholders/2.png'),
          ),

          // Third image
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add the bar-code on the book',
              style: subhead2.copyWith(fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectImage(context, 'third');
            },
            child: _buildImageStack(
                imageObject: third,
                placeholderPath: 'assets/images/placeholders/3.png'),
          ),
          // Fourth image
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add the price tag on the book',
              style: subhead2.copyWith(fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectImage(context, 'fourth');
            },
            child: _buildImageStack(
                imageObject: fourth,
                placeholderPath: 'assets/images/placeholders/4.png'),
          ),
          // Fifth Image
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add a rangom page within the book',
              style: subhead2.copyWith(fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectImage(context, 'fifth');
            },
            child: _buildImageStack(
                imageObject: fifth,
                placeholderPath: 'assets/images/placeholders/5.png'),
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
            body: Form(
              key: _formKey,
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.center,
                shrinkWrap: true,
                children: <Widget>[
                  CustomHeaderBack(
                    title: 'Add book',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _buildName(),
                  _buildMRP(),
                  _buildDescription(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Text(
                      'Add Images',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildBookImage(),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Text(
                  //     'Rapport will never share your Aadhar card details to any of its users or third party platforms.',
                  //     style: subhead2.copyWith(color: Colors.redAccent),
                  //   ),
                  // ),

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
          );
  }
}
