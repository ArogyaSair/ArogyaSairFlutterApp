// ignore_for_file: file_names

import 'package:arogyasair/Login.dart';
import 'package:arogyasair/Registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                      MaterialPageRoute(
                          builder: (context) => const Registration()));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    elevation: 10,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                )),
          ),
        ],
      ),
    );
  }
}
