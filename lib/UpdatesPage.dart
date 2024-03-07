// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'BottomNavigation.dart';
import 'drawerSideNavigation.dart';

class MyUpdates extends StatefulWidget {
  const MyUpdates({Key? key}) : super(key: key);

  @override
  _MyUpdatesState createState() => _MyUpdatesState();
}

class _MyUpdatesState extends State<MyUpdates> {
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
        child: Card(child: Text("Your Updates")),
      ),
    );
  }
}
