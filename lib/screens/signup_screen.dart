import 'package:flutter/material.dart';
import 'package:sebbo/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var username = '';
  var password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Let\'s sign you up for the',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Sebbo App',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text('Do you already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                  child: Text('Login here'),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('Please chose a unique username'),
            TextField(
              onChanged: (value) {
                //We need to make sure the username is unique
                username = value;
              },
              decoration: InputDecoration(
                labelText: 'username',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'This username is valid',
              style: TextStyle(color: Colors.green),
            ),
            SizedBox(height: 20),
            Text('Please enter a secure password'),
            TextField(
              onChanged: (value) {
                password = value;
              },
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'password',
              ),
            ),
            SizedBox(height: 20),
            Text('Re-enter your password'),
            TextField(
              onChanged: (value) {
                password = value;
              },
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'password',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Register'),
                onPressed: () {
                  print(username);
                  print(password);
                },
              ),
            ),
            Expanded(
              child: Container(),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
