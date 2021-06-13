import 'package:flutter/material.dart';

class CustomAppLogo extends StatelessWidget {
  const CustomAppLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(8.0),

      child: Row(
        //Just changed this line, could break SIDE DRAWER
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              width: 42,
            ),
          ),
          Column(
            //Just changed this line, could break SIDE DRAWER
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SEBBO',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 5,
                ),
              ),
              Text(
                'Sell and buy books online',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
