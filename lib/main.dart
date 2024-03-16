// ignore_for_file: use_build_context_synchronously, file_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BottomNavigation.dart';
import 'HospitalHomePage.dart';
import 'LandingPage.dart';
import 'firebase_api.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MaterialApp(home: Splash()));
}

class Splash extends StatefulWidget {
  const Splash({super.key});

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
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
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
        page = const bottomBar();
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
    return MaterialApp(
      builder: (context, child) {
        // Retrieve the MediaQueryData from the current context.
        final mediaQueryData = MediaQuery.of(context);

        // Calculate the scaled text factor using the clamp function to ensure it stays within a specified range.
        final scale = mediaQueryData.textScaler.clamp(
          minScaleFactor: 1.0, // Minimum scale factor allowed.
          maxScaleFactor: 1.3, // Maximum scale factor allowed.
        );

        // Create a new MediaQueryData with the updated text scaling factor.
        // This will override the existing text scaling factor in the MediaQuery.
        // This ensures that text within this subtree is scaled according to the calculated scale factor.
        return MediaQuery(
          // Copy the original MediaQueryData and replace the textScaler with the calculated scale.
          data: mediaQueryData.copyWith(
            textScaler: scale,
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/Logo/ArogyaSair.gif"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
