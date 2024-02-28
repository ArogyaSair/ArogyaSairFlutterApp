import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyTab());
}

class MyTab extends StatelessWidget {
  const MyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyTabPage(),
    );
  }
}

class MyTabPage extends StatefulWidget {
  const MyTabPage({Key? key}) : super(key: key);

  @override
  State<MyTabPage> createState() => _MyTabPageState();
}

class _MyTabPageState extends State<MyTabPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "AS Hospital",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'my_account',
                    child: Text('My Account'),
                  ),
                  const PopupMenuItem(
                    value: 'payment',
                    child: Text('Payment'),
                  ),
                  const PopupMenuItem(
                    value: 'linked_devices',
                    child: Text('Linked Devices'),
                  ),
                  const PopupMenuItem(
                    value: 'new_group',
                    child: Text('New Group'),
                  ),
                  const PopupMenuItem(
                    value: 'new_broadcast',
                    child: Text('New Broadcast'),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: Text('Settings'),
                  ),
                ];
              },
              onSelected: (value) {
                // Handle menu item selection here
                if (value == 'my_account') {
                  // Handle My Account
                } else if (value == 'payment') {
                  // Handle Payment
                } else if (value == 'linked_devices') {
                  // Handle Linked Devices
                } else if (value == 'new_group') {
                  // Handle New Group
                } else if (value == 'new_broadcast') {
                  // Handle New Broadcast
                } else if (value == 'settings') {
                  // Handle Settings
                }
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(text: 'PACKAGES'),
              Tab(text: 'DOCTORS'),
              Tab(text: 'APPOINTMENTS'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
                // child: HospitalPackagesTab(),
                ),
            Center(
                // child: HospitalDoctorTab(),
                ),
            Center(
                // child: HospitalAppointmentTab(),
                ),
          ],
        ),
      ),
    );
  }
}
