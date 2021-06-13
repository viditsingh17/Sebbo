import 'package:flutter/material.dart';

class CustomHeaderBack extends StatelessWidget {
  final String title;
  const CustomHeaderBack({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final WIDTH = size.width;
    final HEIGHT = size.height;
    final HEIGHT10 = HEIGHT / 53;
    final WIDTH10 = WIDTH / 32;
    return Padding(
      padding: EdgeInsets.only(left: WIDTH10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: WIDTH > 350 ? 26 : 20,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: WIDTH > 350 ? 22 : 16,
            ),
          )
        ],
      ),
    );
  }
}
