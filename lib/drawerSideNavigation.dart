// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'package:arogyasair/Login.dart';
import 'package:arogyasair/profile.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about.dart';
import 'contact.dart';
import 'order.dart';

class DrawerCode extends StatefulWidget {
  const DrawerCode({Key? key}) : super(key: key);

  @override
  _DrawerCode createState() => _DrawerCode();
}

class _DrawerCode extends State<DrawerCode> {
  late String username;
  late String email;
  final key = 'username';
  final key1 = 'email';

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
            title: const Text("My Account"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const profile()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: const Text("Settings"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const about()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.medical_services,
              color: Colors.black,
            ),
            title: const Text("My Treatments"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const contact()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.black,
            ),
            title: const Text("About us"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const order()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.email,
              color: Colors.black,
            ),
            title: const Text("Contact us"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const order()));
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
          ),
        ],
      ),
    );
  }
}
