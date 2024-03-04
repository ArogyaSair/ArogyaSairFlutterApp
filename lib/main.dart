// ignore_for_file: use_build_context_synchronously, file_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:firebase_core/firebase_core.dart';
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
    // page = _checkIfLoggedIn();
    await _checkIfLoggedIn();
    await Future.delayed(const Duration(seconds: 5));
    // print(page);
    if (page != null) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    }
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => const MyApp()));
  }

  Future<void> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    containsKey = prefs.containsKey(key);
    containsKey1 = prefs.containsKey(key1);
    // keyToCheck = (await getKey())!;
    // DatabaseReference dbUserRef =
    //     FirebaseDatabase.instance.ref().child("ArogyaSair/tblUser/$keyToCheck");

    // DatabaseEvent databaseEvent = await dbUserRef.once();
    // DataSnapshot dataSnapshot = databaseEvent.snapshot;

    // DatabaseReference dbHospitalRef = FirebaseDatabase.instance
    //     .ref()
    //     .child("ArogyaSair/tblHospital/$keyToCheck");

    // DatabaseEvent databaseEventHospital = await dbHospitalRef.once();
    // DataSnapshot dataSnapshotHospital = databaseEventHospital.snapshot;

    // if (dataSnapshot.value != null || dataSnapshotHospital.value != null) {
    // print("before checking");
    if (containsKey) {
      // Navigator.pop(context);
      page = const HomePage();
      return;
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const HomePage()));
    }
    // print("user checked");
    if (containsKey1) {
      // Navigator.pop(context);
      page = const HospitalHomePage(0);
      return;
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => const HospitalHomePage(0)));
    }
    // print("hospital checked");
    // }
    // else {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.clear();
    //   page = const MyApp();
    //   print("else part");
    // }
    // print("after checking");
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
