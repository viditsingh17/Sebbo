import 'package:flutter/material.dart';
import 'package:sebbo/constants.dart';
import 'package:sebbo/screens/profile_screen.dart';
import 'package:sebbo/widgets/custom_app_logo.dart';
import 'package:sebbo/widgets/custom_drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //design specific variables
    final size = MediaQuery.of(context).size;
    final WIDTH = size.width;
    final HEIGHT = size.height;
    // final HEIGHT10 = HEIGHT / 53;
    // final WIDTH10 = WIDTH / 32;
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: WIDTH > 350 ? 220 : 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: themeGradient,
              ),
              padding: EdgeInsets.symmetric(
                vertical: WIDTH > 350 ? 10 : 5,
                horizontal: WIDTH > 350 ? 15 : 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAppLogo(),
                      WIDTH > 350
                          ? Container()
                          : IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Text(
                    'Hello,',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      'Vidit Singh Brahmania'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Drawer items
          CustomDrawerItem(
            label: 'Home',
            icon: Icons.home_outlined,
            onTap: () {
              print("push home to stack");
            },
          ),
          CustomDrawerItem(
            label: 'Search',
            icon: Icons.search,
            onTap: () {
              print("push search to stack");
            },
          ),
          CustomDrawerItem(
            label: 'My Wallet',
            icon: Icons.account_balance_wallet_outlined,
            onTap: () {
              print("push WalletScreen to stack");
            },
          ),
          CustomDrawerItem(
            label: 'My Cart',
            icon: Icons.shopping_cart_outlined,
            onTap: () {
              print("push home to stack");
            },
          ),
          CustomDrawerItem(
            label: 'My Profile',
            icon: Icons.person_outline_outlined,
            onTap: () {
              Navigator.pushNamed(context, ProfileScreen.profileRoute);
            },
          ),
          Divider(),
          CustomDrawerItem(
            label: 'Logout',
            icon: Icons.logout_outlined,
            onTap: () {
              print("Log the user out");
            },
          ),
          Divider(),
          Expanded(child: Container()),
          Divider(),
          CustomDrawerItem(
            label: 'Settings',
            icon: Icons.settings_outlined,
            onTap: () {
              print("Show settings page");
            },
          )
        ],
      ),
    );
  }
}
