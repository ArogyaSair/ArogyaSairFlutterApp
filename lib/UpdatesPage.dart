// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names

import 'package:arogyasair/drawerSideNavigation.dart';
import 'package:arogyasair/userApprovedDataTab.dart';
import 'package:arogyasair/userDelayedDataTab.dart';
import 'package:arogyasair/userPendingDataTab.dart';
import 'package:flutter/material.dart';

class MyUpdates extends StatefulWidget {
  final String userKey;
  final String userName;

  const MyUpdates(this.userName, this.userKey, {Key? key}) : super(key: key);

  @override
  _MyUpdatesState createState() => _MyUpdatesState();
}

class _MyUpdatesState extends State<MyUpdates> {
  late String imagePath;
  late List<MaterialColor> color = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
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
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(text: 'PENDING'),
              Tab(text: 'DELAYED'),
              Tab(text: 'APPROVED'),
            ],
          ),
        ),
        endDrawer: const DrawerCode(),
        body: TabBarView(
          children: [
            Center(
              child: UserPendingData(widget.userKey, widget.userName),
            ),
            Center(
              child: UserDelayedData(widget.userKey, widget.userName),
            ),
            Center(
              child: UserApprovedData(widget.userKey, widget.userName),
            ),
          ],
        ),
      ),
    );
  }
}
