// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously

import 'package:arogyasair/HospitalProfilePage.dart';
import 'package:arogyasair/firebase_api.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HospitalAppointmentTab.dart';
import 'HospitalDoctorTab.dart';
import 'HospitalPackagesTab.dart';
import 'LandingPage.dart';

class HospitalHomePage extends StatefulWidget {
  final int indexPage;

  const HospitalHomePage(this.indexPage, {super.key});

  @override
  _HospitalHomePage createState() => _HospitalHomePage();
}

class _HospitalHomePage extends State<HospitalHomePage> {
  Query dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospital');
  late String hospitalName;
  late String hospitalKey;
  final key = 'HospitalName';
  late bool containsKey;
  var logger = Logger();
  late String displayName;
  final _messagingService = MessagingService();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late String? fcmToken;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    await _messagingService.init(context);
    String? userData = await getData(key);
    String? userKey = await getKey();
    setState(() {
      hospitalName = userData!;
      hospitalKey = userKey!;
      if (hospitalName.contains("Hospital") ||
          hospitalName.contains("hospital")) {
        displayName = "AS $hospitalName";
      } else {
        displayName = "AS $hospitalName Hospital";
      }
    });
    fcmToken = await _fcm.getToken();
    final updatedData = {
      "HospitalFCMToken": fcmToken,
    };
    final userRef = FirebaseDatabase.instance
        .ref()
        .child("ArogyaSair/tblHospital")
        .child(hospitalKey);
    await userRef.update(updatedData);
  }

  @override
  Widget build(BuildContext context) {
    if (displayName.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return DefaultTabController(
        initialIndex: widget.indexPage,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              displayName,
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: 'my_account',
                      child: Text('My Account'),
                    ),
                    const PopupMenuItem(
                      value: 'settings',
                      child: Text('Settings'),
                    ),
                    const PopupMenuItem(
                      value: 'logout',
                      child: Text('Logout'),
                    ),
                  ];
                },
                onSelected: (value) async {
                  // Handle menu item selection here
                  if (value == 'my_account') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HospitalProfile()));
                  } else if (value == 'settings') {
                    // Handle Settings
                  } else if (value == 'logout') {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyApp(),
                      ),
                    );
                  }
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(text: 'PACKAGES'),
                Tab(text: 'DOCTORS'),
                Tab(text: 'APPOINTMENTS'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: HospitalPackagesTab(hospitalKey),
              ),
              Center(
                child: HospitalDoctorTab(hospitalKey),
              ),
              Center(
                child: HospitalAppointmentTab(hospitalKey),
              ),
            ],
          ),
        ),
      );
    }
  }
}
