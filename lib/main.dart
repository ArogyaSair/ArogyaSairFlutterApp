// ignore_for_file: non_constant_identifier_names, camel_case_types, library_private_types_in_public_api, use_build_context_synchronously

import 'package:arogyasair/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';
import 'Login.dart';
import 'Registration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String data = "";
  final key = 'username';
  late bool containsKey;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    containsKey = prefs.containsKey(key);

    if (containsKey) {
      // If the key exists, navigate to HomePage
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset("assets/Logo/ArogyaSair.png"),
          Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Registration()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                elevation: 10,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Register",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                elevation: 10,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
