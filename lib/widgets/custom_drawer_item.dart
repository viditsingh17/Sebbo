import 'package:flutter/material.dart';

class CustomDrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final onTap;
  const CustomDrawerItem({Key key, this.icon, this.label, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //design specific variables
    final size = MediaQuery.of(context).size;
    final WIDTH = size.width;
    final HEIGHT = size.height;
    // final HEIGHT10 = HEIGHT / 53;
    // final WIDTH10 = WIDTH / 32;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: WIDTH > 350 ? 20 : 15,
          vertical: WIDTH > 350 ? 15 : 8,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black.withOpacity(0.7),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: WIDTH > 350 ? 18 : 15,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.7),
              ),
            )
          ],
        ),
      ),
    );
  }
}
