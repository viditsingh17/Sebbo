import 'package:flutter/material.dart';
import 'package:sebbo/config/constants.dart';

class MyAlertDialog extends StatefulWidget {
  final List<Widget> actions;
  final String message;

  const MyAlertDialog({Key key, this.actions, this.message});
  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Are you sure?",
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
//        title: Text('Are you sure?', style: heading1,),
      content: Text(
//        'Are you sure you want to logout?',
        widget.message,
        style: subhead2.copyWith(
            fontSize: 14, color: Colors.black.withOpacity(0.8)),
      ),
      actions: widget.actions,
    );
  }
}
