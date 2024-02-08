// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api

import 'package:arogyasair/HelpDeskPage.dart';
import 'package:arogyasair/HistoryPage.dart';
import 'package:arogyasair/HomePage.dart';
import 'package:arogyasair/ProfilePage.dart';
import 'package:arogyasair/UpdatesPage.dart';
import 'package:flutter/material.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({Key? key}) : super(key: key);

  @override
  _bottomBarState createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  static int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.of(context).pop();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else if (index == 1) {
      Navigator.of(context).pop();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyUpdates()));
    } else if (index == 2) {
      Navigator.of(context).pop();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyHistory()));
    } else if (index == 3) {
      Navigator.of(context).pop();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHelpDesk()));
    } else if (index == 4) {
      Navigator.of(context).pop();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyProfile()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home',
            backgroundColor: Colors.blue),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.update_rounded,
            size: 30,
          ),
          label: 'Updates',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.history_rounded,
            size: 30,
          ),
          label: 'History',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.support,
            size: 30,
          ),
          label: 'Help Desk',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
            size: 30,
          ),
          label: 'Profile',
          backgroundColor: Colors.blue,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}
