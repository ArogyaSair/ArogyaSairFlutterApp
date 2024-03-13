// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:async';

import 'package:arogyasair/AppointmentDateselecation.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class PackageHospitalSelection extends StatefulWidget {
  final String item;

  const PackageHospitalSelection({super.key, required this.item});

  @override
  State<PackageHospitalSelection> createState() => _HospitalPackagesTabState();
}

class _HospitalPackagesTabState extends State<PackageHospitalSelection> {
  late DatabaseReference dbRef;
  var logger = Logger();
  late String UserKey;
  final key = 'userKey';
  late bool containsKey;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospital');
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? HospitalKey = await getKey();
    setState(() {
      UserKey = HospitalKey!;
    });
  }

  Future<List<Map>> getHospitalData() async {
    DatabaseEvent event = await dbRef.once();
    DataSnapshot snapshot = event.snapshot;

    // Check if data exists
    if (snapshot.value == null) {
      // Handle no data scenario
      return []; // Return empty list if no data
    }

    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    List<Map> hospitals = [];

    values.forEach((key, value) {
      // print("key is $key");
      if (value['Photo'] != null && value['Photo'].toString().isNotEmpty) {
        hospitals.add({
          'HospitalName': value['HospitalName'],
          'Photo': value["Photo"],
          'Key': key,
        });
      } else {
        hospitals.add({
          'HospitalName': value['HospitalName'],
          'Photo': 'ArogyaSair.png',
          'Key': key,
        });
      }
    });
    return hospitals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hospitals",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Map>>(
        future: getHospitalData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Map>? hospitals = snapshot.data;
            if (hospitals != null && hospitals.isNotEmpty) {
              return ListView.builder(
                itemCount: hospitals.length,
                itemBuilder: (context, index) {
                  Map data1 = hospitals[index];
                  var imageName = data1['Photo'] == 'noimage'
                      ? 'noimage'
                      : "HospitalImage%2F${data1['Photo']}";
                  var imagePath = data1['Photo'] == 'noimage'
                      ? 'https://via.placeholder.com/150' // Placeholder image URL
                      : "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/$imageName?alt=media";
                  return ListTile(
                    contentPadding: const EdgeInsets.all(1),
                    leading: Image.network(imagePath),
                    title: Text(data1['HospitalName'].toString()),
                    onTap: () {
                      // Navigate to a new page on item click
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentDateSelection(
                            HospitalName: data1["HospitalName"],
                            HospitalKey: data1["Key"],
                            item: widget.item,
                          ), // Pass data to the new page
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text('No hospitals found'));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
