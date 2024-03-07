// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'drawerSideNavigation.dart';

class MyHelpDesk extends StatefulWidget {
  @override
  _MyHelpDeskState createState() => _MyHelpDeskState();
}

class _MyHelpDeskState extends State<MyHelpDesk> {
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
      body: const Center(
        child: Text("How Can I Help You ?"),
      ),
    );
  }
}
