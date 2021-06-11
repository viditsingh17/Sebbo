import 'package:flutter/material.dart';
import 'package:sebbo/constants.dart';
import 'package:sebbo/screens/profile_screen.dart';
import 'package:sebbo/widgets/custom_app_logo.dart';
import 'package:sebbo/widgets/custom_drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: themeGradient,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Transform.scale(
                      scale: 0.9,
                      child: CustomAppLogo(),
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
          ),
        ],
      ),
    );
  }
}
