// ignore_for_file: file_names, use_build_context_synchronously

import 'package:arogyasair/HospitalPasswordChange.dart';
import 'package:arogyasair/HospitalSideDrawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LandingPage.dart';

class HospitalHomePage extends StatefulWidget {
  const HospitalHomePage({Key? key}) : super(key: key);

  @override
  State<HospitalHomePage> createState() => _HospitalHomePageState();
}

class _HospitalHomePageState extends State<HospitalHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Text(
          'AS Hospital',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      endDrawer: const HospitalDrawerCode(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HospitalChangePassword()));
            },
            child: const Text("Change Password"),
          ),
          ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyApp()));
            },
            child: const Text("Log out"),
          ),
        ],
      ),
    );
  }
}
