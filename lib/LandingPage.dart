// ignore_for_file: non_constant_identifier_names, camel_case_types, library_private_types_in_public_api, use_build_context_synchronously, file_names

import 'package:arogyasair/HospitalHomePage.dart';
import 'package:arogyasair/HospitalLandingPage.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';
import 'Login.dart';
import 'Registration.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String data = "";
  final key = 'username';
  final key1 = 'HospitalEmail';
  late bool containsKey;
  late bool containsKey1;
  late String KeyToCheck;

  var logger = Logger();

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    containsKey = prefs.containsKey(key);
    containsKey1 = prefs.containsKey(key1);
    KeyToCheck = (await getKey())!;
    DatabaseReference dbUserRef =
        FirebaseDatabase.instance.ref().child("ArogyaSair/tblUser/$KeyToCheck");

    DatabaseEvent databaseEvent = await dbUserRef.once();
    DataSnapshot dataSnapshot = databaseEvent.snapshot;

    DatabaseReference dbHospitalRef = FirebaseDatabase.instance
        .ref()
        .child("ArogyaSair/tblHospital/$KeyToCheck");

    DatabaseEvent databaseEventHospital = await dbHospitalRef.once();
    DataSnapshot dataSnapshotHospital = databaseEventHospital.snapshot;

    if (dataSnapshot.value != null || dataSnapshotHospital.value != null) {
      logger.d("Has Data");
      if (containsKey) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
      if (containsKey1) {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HospitalHomePage(0)));
      }
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/Logo/ArogyaSair.png"),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Registration()),
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
            Padding(
              padding: const EdgeInsets.all(1),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HospitalLandingPage()),
                  );
                },
                child: const Text(
                  "For Hospital",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
