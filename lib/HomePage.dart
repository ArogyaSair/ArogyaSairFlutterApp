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
    // Call your asynchronous function here
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
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      endDrawer: const DrawerCode(),
      body: Text(data),
    );
  }
}
