// ignore_for_file: file_names

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HospitalAppointmentTab extends StatefulWidget {
  final String hospitalKey;

  const HospitalAppointmentTab(this.hospitalKey, {Key? key}) : super(key: key);

  @override
  State<HospitalAppointmentTab> createState() => _HospitalAppointmentTab();
}

class _HospitalAppointmentTab extends State<HospitalAppointmentTab> {
  late DatabaseReference dbRef;
  var logger = Logger();
  String imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2FArogyaSair.png?alt=media";

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospital');
  }

  Future<List<Map>> getHospitalData() async {
    DatabaseEvent event = await dbRef.once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value == null) {
      return [];
    }

    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    List<Map> hospitals = [];

    values.forEach((key, value) {
      if (value['Photo'] != null && value['Photo'].toString().isNotEmpty) {
        hospitals.add({
          'HospitalName': value['HospitalName'],
          'Photo': value["Photo"],
        });
      } else {
        hospitals.add({
          'HospitalName': value['HospitalName'],
          // 'Duration': value['Duration'],
          'Photo': 'ArogyaSair.png',
        });
      }
    });

    return hospitals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  imagePath = data1['Photo'] == 'noimage'
                      ? 'https://via.placeholder.com/150' // Placeholder image URL
                      : "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/$imageName?alt=media";
                  return ListTile(
                    contentPadding: const EdgeInsets.all(1),
                    leading: Image.network(imagePath),
                    title: Text(data1['HospitalName'].toString()),
                    // subtitle: Text(data1['Duration'].toString()),
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
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.blue),
          ),
        ),
      ),
    );
  }
}
