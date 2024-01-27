// ignore_for_file: non_constant_identifier_names

import 'package:arogyasair/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Login.dart';
import 'Registration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(home: splash()));
}

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Center(
            child: Image.asset('assets/Logo/ArogyaSair.png'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Registration()),
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 50),
              elevation: 10,
            ),
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 19),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 50),
              backgroundColor: Colors.white,
              elevation: 10,
            ),
            child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 19,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
