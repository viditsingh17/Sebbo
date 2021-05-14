import 'package:flutter/material.dart';
import 'package:sebbo/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              'Welcome to',
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
            Text('To continue please login'),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                username = value;
              },
              decoration: InputDecoration(
                labelText: 'username',
              ),
            ),
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
                child: Text('Login'),
                onPressed: () {
                  print(username);
                  print(password);
                },
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              children: [
                Text('Do not have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SignUpScreen();
                    }));
                  },
                  child: Text('Register'),
                )
              ],
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
