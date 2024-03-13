// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api

import 'package:arogyasair/HelpDeskPage.dart';
import 'package:arogyasair/HistoryPage.dart';
import 'package:arogyasair/HomePage.dart';
import 'package:arogyasair/ProfilePage.dart';
import 'package:arogyasair/UpdatesPage.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<bottomBar> {
  static int _selectedIndex = 0;
  late String username;
  late String email;
  final key = 'username';
  final key1 = 'email';
  late String userKey;
  List<Widget> _widgetOptions = [];

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
    _widgetOptions = <Widget>[
      const Scaffold(
        backgroundColor: Colors.white,
        body: HomePage(),
      ),
      Scaffold(
        backgroundColor: Colors.white,
        body: MyUpdates(username, userKey),
      ),
      const Scaffold(
        backgroundColor: Colors.white,
        body: MyHistory(),
      ),
      Scaffold(
        backgroundColor: Colors.white,
        body: MyHelpDesk(),
      ),
      Scaffold(
        backgroundColor: Colors.white,
        body: MyProfile(username, email),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Colors.blue.shade500,
          animationDuration: const Duration(milliseconds: 500),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.update,
              color: Colors.white,
            ),
            Icon(
              Icons.history,
              color: Colors.white,
            ),
            Icon(
              Icons.support,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              color: Colors.white,
            ),
          ],
          index: _selectedIndex, // Use 'index' instead of 'currentIndex'
        ),
      ),
    );
  }
}
