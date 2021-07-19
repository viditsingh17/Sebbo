import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sebbo/config/constants.dart';
import 'package:sebbo/screens/add_image_screen_2.dart';
import 'package:sebbo/screens/add_image_screen_4.dart';
import 'package:sebbo/widgets/custom_header_back.dart';

class AddImage3 extends StatefulWidget {
  static const String addImage3Route = '/home/add_image_3';
  const AddImage3({Key key}) : super(key: key);

  @override
  _AddImage3State createState() => _AddImage3State();
}

class _AddImage3State extends State<AddImage3> {
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  PickedFile third;

  handleTakePhoto(String title) async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    PickedFile file = await _picker.getImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    // setState(() {
    if (title == 'third') {
      this.third = file;
      //   } else if (title == 'second') {
      //     this.second = file;
      //   } else if (title == 'third') {
      //     this.third = file;
      //   } else if (title == 'fourth') {
      //     this.fourth = file;
      //   } else if (title == 'fifth') {
      //     this.fifth = file;
      //   }
      // });
    }
  }

  handleChooseFromGallery(String title) async {
    Navigator.pop(context);
    PickedFile file = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (title == 'third') {
        this.third = file;
        // } else if (title == 'second') {
        //   this.second = file;
        // } else if (title == 'third') {
        //   this.third = file;
        // } else if (title == 'fourth') {
        //   this.fourth = file;
        // } else if (title == 'fifth') {
        //   this.fifth = file;
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

  Widget _buildImageStack({var imageObject, String placeholderPath}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(8.9),
          height: MediaQuery.of(context).size.height * 0.35,
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
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add the bar-code on the book',
              style: subhead2.copyWith(fontSize: 18),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectImage(context, 'first');
            },
            child: Container(
              alignment: Alignment.center,
              child: _buildImageStack(
                  imageObject: third,
                  placeholderPath: 'assets/images/placeholders/3.png'),
            ),
          ),
          // // Second page
          // SizedBox(
          //   height: 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Text(
          //     'Add last page of the book',
          //     style: subhead2.copyWith(fontSize: 14),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     selectImage(context, 'second');
          //   },
          //   child: _buildImageStack(
          //       imageObject: second,
          //       placeholderPath: 'assets/images/placeholders/2.png'),
          // ),

          // // Third image
          // SizedBox(
          //   height: 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Text(
          //     'Add the bar-code on the book',
          //     style: subhead2.copyWith(fontSize: 14),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     selectImage(context, 'third');
          //   },
          //   child: _buildImageStack(
          //       imageObject: third,
          //       placeholderPath: 'assets/images/placeholders/3.png'),
          // ),
          // // Fourth image
          // SizedBox(
          //   height: 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Text(
          //     'Add the price tag on the book',
          //     style: subhead2.copyWith(fontSize: 14),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     selectImage(context, 'fourth');
          //   },
          //   child: _buildImageStack(
          //       imageObject: fourth,
          //       placeholderPath: 'assets/images/placeholders/4.png'),
          // ),
          // // Fifth Image
          // SizedBox(
          //   height: 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Text(
          //     'Add a rangom page within the book',
          //     style: subhead2.copyWith(fontSize: 14),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     selectImage(context, 'fifth');
          //   },
          //   child: _buildImageStack(
          //       imageObject: fifth,
          //       placeholderPath: 'assets/images/placeholders/5.png'),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          CustomHeaderBack(
            title: 'Add Image',
          ),
          _buildBookImage(),
          myRaisedButton(
            label: 'Next',
            onPressed: () {
              // _formKey.currentState.save();
              //TODO: I've removed the firebase function, please handle it
              // createFirebase();
              Navigator.of(context).pushNamed(AddImage4.addImage4Route);
            },
          ),
        ],
      ),
    );
  }
}
