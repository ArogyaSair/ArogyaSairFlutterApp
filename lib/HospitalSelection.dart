// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:async';

import 'package:arogyasair/AppointmentDateselecation.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'models/SurgeryData.dart';

class PackageHospitalSelection extends StatefulWidget {
  final SurgeryModel diseaseList;

  const PackageHospitalSelection({super.key, required this.diseaseList});

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
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? HospitalKey = await getKey();
    setState(() {
      UserKey = HospitalKey!;
    });
    dbRef = FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospital');
  }

  Future<List<Map>> getHospitalData() async {
    DatabaseEvent event = await dbRef.once();
    DataSnapshot snapshot = event.snapshot;

    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    List<Map> hospitals = [];

    // print("values $values");

    values.forEach((key, value) {
      if (value['AvailableSurgeries'].contains(widget.diseaseList.surgery)) {
        if (value['Photo'] != null && value['Photo'].toString().isNotEmpty) {
          hospitals.add({
            'HospitalName': value['HospitalName'],
            'Photo': value["Photo"],
            'AvailableDisease': value['AvailableSurgeries'],
            'Key': key,
          });
        } else {
          hospitals.add({
            'HospitalName': value['HospitalName'],
            'Photo': 'ArogyaSair.png',
            'Key': key,
            'AvailableDisease': value['AvailableSurgeries'],
          });
        }
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
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xfff2f6f7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0xfff2f6f7),
        child: FutureBuilder<List<Map>>(
          future: getHospitalData(),
          builder: (context, snapshot) {
            List<Map>? hospitals = snapshot.data;
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
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
                    return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(1),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              imagePath,
                              width: MediaQuery.of(context).size.width * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(data1['HospitalName'].toString()),
                          onTap: () {
                            // Navigate to a new page on item click
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppointmentDateSelection(
                                  HospitalName: data1["HospitalName"],
                                  HospitalKey: data1["Key"],
                                  item: widget.diseaseList,
                                ), // Pass data to the new page
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No hospitals found'));
              }
            }
          },
        ),
      ),
    );
  }
}
