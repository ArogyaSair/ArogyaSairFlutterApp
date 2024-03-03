import 'package:flutter/material.dart';

import 'Login.dart';

void main() {
  runApp(const MaterialApp(home: Login1()));
}

class Login1 extends StatefulWidget {
  const Login1({Key? key}) : super(key: key);

  @override
  State<Login1> createState() => _LoginState();
}

class _LoginState extends State<Login1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF0D47A1), Colors.lightBlue])),
          child: const Padding(
            padding: EdgeInsets.only(top: 60, left: 22),
            child: Text(
              "Login",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: const Login(),
          ),
        ),
      ],
    ));
  }
}
