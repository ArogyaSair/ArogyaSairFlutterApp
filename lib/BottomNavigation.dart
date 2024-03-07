// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api

import 'package:arogyasair/HelpDeskPage.dart';
import 'package:arogyasair/HistoryPage.dart';
import 'package:arogyasair/HomePage.dart';
import 'package:arogyasair/ProfilePage.dart';
import 'package:arogyasair/UpdatesPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({Key? key}) : super(key: key);

  @override
  _bottomBarState createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  static int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          backgroundColor: Colors.blue,
          color: Colors.white,
          activeColor: Colors.blue,
          tabBackgroundColor: Colors.white,
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
              gap: 8,
              padding: const EdgeInsets.all(14),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
            GButton(
              icon: Icons.update_rounded,
              text: 'Updates',
              gap: 8,
              padding: const EdgeInsets.all(14),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyUpdates(),
                  ),
                );
              },
            ),
            GButton(
              icon: Icons.history_rounded,
              text: 'History',
              gap: 8,
              padding: const EdgeInsets.all(14),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHistory(),
                  ),
                );
              },
            ),
            GButton(
              icon: Icons.support,
              text: 'Help',
              gap: 8,
              padding: const EdgeInsets.all(14),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHelpDesk(),
                  ),
                );
              },
            ),
            GButton(
              icon: Icons.person_outline,
              text: 'My Profile',
              gap: 8,
              padding: const EdgeInsets.all(14),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyProfile(),
                  ),
                );
              },
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
