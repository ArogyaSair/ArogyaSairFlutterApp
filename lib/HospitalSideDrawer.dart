// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'package:arogyasair/HospitalProfilePage.dart';
import 'package:arogyasair/LandingPage.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HospitalDrawerCode extends StatefulWidget {
  const HospitalDrawerCode({super.key});

  @override
  _DrawerCode createState() => _DrawerCode();
}

class _DrawerCode extends State<HospitalDrawerCode> {
  late String username;
  late String email;
  late String userKey;

  final key1 = 'HospitalEmail';
  final key = 'HospitalName';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? userData = await getData(key);
    String? userEmail = await getData(key1);
    String? userkey = await getKey();
    setState(() {
      username = userData!;
      email = userEmail!;
      userKey = userkey!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: [
          Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  width: 70,
                  height: 70,
                  padding: const EdgeInsets.only(bottom: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    // Set your desired border radius
                    child: Image.asset(
                      'assets/Logo/ArogyaSair.png',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 5,
            color: Color(0xFFE0E3E7),
          ),
          ListTile(
            leading: const Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            title: const Text("My Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HospitalProfile(),
                ),
              );
            },
          ),
          const Divider(
            thickness: 5,
            color: Color(0xFFE0E3E7),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
            title: const Text("Log out"),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
