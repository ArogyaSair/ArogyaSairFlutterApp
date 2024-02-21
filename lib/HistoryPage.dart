// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

import 'BottomNavigation.dart';
import 'drawerSideNavigation.dart';

class MyHistory extends StatefulWidget {
  const MyHistory({Key? key}) : super(key: key);

  @override
  _MyHistoryState createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Text(
          'Arogya Sair',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      endDrawer: const DrawerCode(),
      bottomNavigationBar: const bottomBar(),
      body: const Center(
        child: Text("Your History"),
      ),
    );
  }
}