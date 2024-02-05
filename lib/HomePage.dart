// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors

import 'package:arogyasair/drawerSideNavigation.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late String data;
  final key = 'username';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? userData = await getData(key);
    setState(() {
      data = userData!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 16.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: const Text('Arogya Sair'),
        ),
        endDrawer: DrawerCode(),
        body: Text(data),
      ),
    );
  }
}
