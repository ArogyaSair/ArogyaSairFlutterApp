// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors

import 'package:arogyasair/drawerSideNavigation.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Query dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospital');
  late String data;
  final key = 'username';
  late bool containsKey;

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
          title: const Text(
            'Arogya Sair',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        endDrawer: DrawerCode(),
        body: Column(
          children: [
            Flexible(
              child: FirebaseAnimatedList(
                query: dbRef2,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map data1 = snapshot.value as Map;
                  var imageName = "HospitalImage%2F${data1['Photo']}";
                  var imagePath =
                      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/$imageName?alt=media";

                  return ListTile(
                    contentPadding: EdgeInsets.all(1),
                    // leading: Icon(Icons.query_builder),
                    leading: Image.network(imagePath),
                    // leading: Image.network("https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/CategoryImage%2Fblouse.jpg?alt=media"),
                    title: Text(data1['HospitalName'].toString()),
                    subtitle: Text(data1['HospitalCity'].toString()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
