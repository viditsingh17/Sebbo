import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sebbo/constants.dart';
import 'package:sebbo/widgets/custom_header_back.dart';

class ProfileScreen extends StatefulWidget {
  static String profileRoute = '/home/profile';
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    //design specific
    final size = MediaQuery.of(context).size;
    final WIDTH = size.width;
    final HEIGHT = size.height;
    final HEIGHT10 = HEIGHT / 53;
    final WIDTH10 = WIDTH / 32;
    //first name only
    final String _name = 'Vidit Singh Brahmania';
    final String _numberOfBookskListed = '21';
    final String _numberOfBooksSold = '5';
    final String _credits = '121';
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          CustomHeaderBack(
            title: 'Profile',
          ),
          Padding(
            padding: EdgeInsets.only(
              top: WIDTH > 350 ? 30 : 15,
              left: 18.0,
            ),
            child: Text(
              'Vidit Singh Brahmania',
              style: TextStyle(
                fontSize: WIDTH > 350 ? 50 : 36,
                color: Colors.black,
                height: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
            ),
            child: Text(
              'Seller/Buyer',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: TextButton(
              onPressed: () {
                debugPrint('Edit Profile');
              },

              //This is just shown to self
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Edit Profile'),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: WIDTH > 350 ? 20 : 10,
              vertical: WIDTH > 350 ? 70 : 35,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconValueBuilder(
                    Icons.account_balance_wallet_outlined, _credits, 'Credit'),
                _iconValueBuilder(
                    Icons.auto_stories, _numberOfBookskListed, 'Books'),
                _iconValueBuilder(Icons.store_mall_directory_outlined,
                    _numberOfBooksSold, 'Sold'),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(5),
            itemCount: 21,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (ctx, i) => Image.network('https://picsum.photos/200'),
          )
        ],
      ),
    );
  }

  Widget _iconValueBuilder(icon, value, label) {
    final WIDTH = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Icon(
            icon,
            size: WIDTH > 350 ? 100 : 75,
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
        Container(
          height: 60,
          width: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: subhead2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
