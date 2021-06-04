import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Primary theme color of the app
//const themeColor = Color.fromRGBO(0, 136, 170, 1);
const themeColor = Color.fromRGBO(25, 42, 86, 1);

const leftTextInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10),
    bottomLeft: Radius.circular(10),
  ),
);

const rightTextInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(10),
    bottomRight: Radius.circular(10),
  ),
);

const completeInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

//Text styles

//small heading
TextStyle heading1 = GoogleFonts.montserrat(
  fontSize: 20,
  fontWeight: FontWeight.w700,
);

//small heading with Roboto
TextStyle heading2 = GoogleFonts.roboto(
  fontSize: 20,
  fontWeight: FontWeight.w700,
);

//description
TextStyle subhead1 = GoogleFonts.montserrat(
  fontSize: 10,
  color: Colors.black54,
);

//subheading
TextStyle subhead2 = GoogleFonts.montserrat(
  fontSize: 12,
  color: Colors.black54,
);

TextStyle normalText = GoogleFonts.roboto(
  fontSize: 16,
);

//AppBar Text Style

TextStyle appBarTextStyle = heading1.copyWith(fontSize: 20);

//Custom Input decoration
InputDecoration myInputDecoration({label, hint, prefixIcon}) {
  return InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.all(15),
    labelText: label,
    labelStyle: subhead2,
    hintText: hint,
    hintStyle: subhead1.copyWith(fontSize: 12),
    prefixIcon: prefixIcon,
    focusedBorder: completeInputBorder,
    border: completeInputBorder,
  );
}

//Custom Input Field
Widget myTextField({onChanged, label, keyboardType}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
    child: TextField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: myInputDecoration(label: label),
    ),
  );
}

//Customized Form Field
Widget myFromField(
    {label,
      hint,
      validator,
      onSaved,
      onChanged,
      keyBoardType: TextInputType.text,
      controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
    child: TextFormField(
      controller: controller,
      keyboardType: keyBoardType,
      decoration: myInputDecoration(
        label: label,
        hint: hint,
      ),
      onChanged: onChanged,
      validator: validator,
      onSaved: onSaved,
    ),
  );
}

//Customized raisedButton
Widget myRaisedButton({onPressed, label}) {
  return Container(
    margin: EdgeInsets.all(10),
    width: double.infinity,
    height: 50,
    child: RaisedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
//          color: Colors.white,
          color: themeColor,
//
//                            fontWeight: FontWeight.bold,
        ),
      ),
//                          color: Color.fromRGBO(119, 205, 208, 1),
//      color: themeColor,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: themeColor,
        ),
      ),
    ),
  );
}

//Student Tag
Widget studentTag = Container(
  alignment: Alignment.centerLeft,
  child: Container(
    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    margin: EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: Colors.blue.withOpacity(0.8),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      'Student',
      style: subhead1.copyWith(color: Colors.white),
    ),
  ),
);

//Student Tag
Widget teacherTag = Container(
  alignment: Alignment.centerLeft,
  child: Container(
    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    margin: EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: Colors.red.withOpacity(0.8),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      'Teacher',
      style: subhead1.copyWith(color: Colors.white),
    ),
  ),
);

//This function makes the text string for the message when a post is shared on WhatsApp
String shareText(String captions) {
  return '''
  Check this post out from Rapport.
  
  *$captions*
  
  _Rapport is an app that helps students to find teachers that suit them._
  Download Rapport: https://play.google.com/store/apps/details?id=com.softjectico.teamrapport
  ''';
}

String shareApp() {
  return '''
  *Rapport is an app that helps students to find teachers that suit them.*
  Download Rapport: https://play.google.com/store/apps/details?id=com.softjectico.teamrapport
  ''';
}
