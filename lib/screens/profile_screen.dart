import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sebbo/constants.dart';

class ProfileScreen extends StatefulWidget {
  static String profileRoute = '/home/profile';
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final String _name = 'Vidit Singh Brahmania';
    final String _numberOfBookskListed = '21';
    final String _numberOfBooksSold = '5';
    final String _credits = '121';
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 160,
                      width: 160,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(55),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          print('Open the book listing');
                        },
                        child: Image.network(
                          'https://picsum.photos/200',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                Text(
                  'Vidit Singh Brahmania',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('Edit Profile');
                  },
                  child: Text('Edit Profile'),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _iconValueBuilder(Icons.account_balance_wallet_outlined,
                          _credits, 'Credit'),
                      _iconValueBuilder(
                          Icons.auto_stories, _numberOfBookskListed, 'Books'),
                      _iconValueBuilder(Icons.store_mall_directory_outlined,
                          _numberOfBooksSold, 'Sold'),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 70,
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
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Icon(
            icon,
            size: 100,
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
