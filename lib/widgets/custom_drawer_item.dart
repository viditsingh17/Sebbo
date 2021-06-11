import 'package:flutter/material.dart';

class CustomDrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final onTap;
  const CustomDrawerItem({Key key, this.icon, this.label, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
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
                fontSize: 18,
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
