// ignore_for_file: use_build_context_synchronously, file_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';
import 'HospitalHomePage.dart';
import 'LandingPage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: Splash()));
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  splash createState() => splash();
}

class splash extends State<Splash> {
  String data = "";
  final key = 'username';
  final key1 = 'HospitalEmail';
  late bool containsKey;
  late bool containsKey1;
  late String keyToCheck;
  var page;

  @override
  void initState() {
    super.initState();
    {
      navigateToHome();
    }
  }

  navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5));
    await _checkIfLoggedIn();
    if (page != null) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    }
  }

  Future<void> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    containsKey = prefs.containsKey(key);
    containsKey1 = prefs.containsKey(key1);

    if (containsKey) {
      keyToCheck = (await getKey())!;
      DatabaseReference dbUserRef = FirebaseDatabase.instance
          .ref()
          .child("ArogyaSair/tblUser/$keyToCheck");

      DatabaseEvent databaseEvent = await dbUserRef.once();
      DataSnapshot dataSnapshot = databaseEvent.snapshot;
      if (dataSnapshot.value != null) {
        page = const HomePage();
      }
      return;
    }
    if (containsKey1) {
      keyToCheck = (await getKey())!;
      DatabaseReference dbHospitalRef = FirebaseDatabase.instance
          .ref()
          .child("ArogyaSair/tblHospital/$keyToCheck");

      DatabaseEvent databaseEventHospital = await dbHospitalRef.once();
      DataSnapshot dataSnapshotHospital = databaseEventHospital.snapshot;
      if (dataSnapshotHospital.value != null) {
        page = const HospitalHomePage(0);
      }
      return;
    }
    page = const MyApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/Logo/ArogyaSair.gif")],
        ),
      ),
    );
  }
}
