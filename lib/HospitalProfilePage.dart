// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:arogyasair/HospitalPasswordChange.dart';
import 'package:arogyasair/HospitalSideDrawer.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import 'HospitalEditProfile.dart';

class HospitalProfile extends StatefulWidget {
  const HospitalProfile({super.key});

  @override
  _HospitalProfileState createState() => _HospitalProfileState();
}

class _HospitalProfileState extends State<HospitalProfile> {
  late String username;
  late String email;
  final key = 'HospitalName';
  final key1 = 'HospitalEmail';
  late String displayName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? userData = await getData(key);
    String? userEmail = await getData(key1);
    setState(() {
      username = userData!;
      email = userEmail!;
      if (username.contains("Hospital") || username.contains("hospital")) {
        displayName = "AS $username";
      } else {
        displayName = "AS $username Hospital";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: SizedBox(
          width: double.infinity,
          height: 30,
          child: Marquee(
            text: displayName,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            scrollAxis: Axis.horizontal,
            blankSpace: 10.0,
            velocity: 30.0,
            pauseAfterRound: const Duration(seconds: 3),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      endDrawer: const HospitalDrawerCode(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 5, 0, 0),
            child: Text(
              username,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 2, 0, 0),
            child: Text(
              email,
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            child: InkWell(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HospitalEditProfile()));
              },
              child: const Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 0, 20),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HospitalChangePassword()));
            },
            child: const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 20, 0, 20),
                    child: Text(
                      "Change Password",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 2,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.white12,
          ),
        ],
      ),
    );
  }
}
