// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names

import 'package:arogyasair/drawerSideNavigation.dart';
import 'package:arogyasair/userApprovedDataTab.dart';
import 'package:arogyasair/userDelayedDataTab.dart';
import 'package:arogyasair/userPendingDataTab.dart';
import 'package:flutter/material.dart';

class MyUpdates extends StatefulWidget {
  final String userKey;
  final String userName;

  const MyUpdates(this.userName, this.userKey, {super.key});

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
          backgroundColor: const Color(0xfff2f6f7),
          automaticallyImplyLeading: false,
          title: const Text(
            'Appointment Updates',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Color(0xff12d3c6)),
          bottom: const TabBar(
            indicatorColor: Color(0xff12d3c6),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                  child: Text(
                "PENDING",
                style: TextStyle(color: Color(0xff12d3c6)),
              )),
              Tab(
                  child: Text(
                "DELAYED",
                style: TextStyle(color: Color(0xff12d3c6)),
              )),
              Tab(
                  child: Text(
                "APPROVED",
                style: TextStyle(color: Color(0xff12d3c6)),
              )),
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
