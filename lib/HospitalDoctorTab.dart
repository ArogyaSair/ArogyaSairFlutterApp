// ignore_for_file: file_names

import 'dart:async';

import 'package:arogyasair/hospitalDoctorAdd.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HospitalDoctorTab extends StatefulWidget {
  final String hospitalKey;

  const HospitalDoctorTab(this.hospitalKey, {Key? key}) : super(key: key);

  @override
  State<HospitalDoctorTab> createState() => _HospitalDoctorTabState();
}

class _HospitalDoctorTabState extends State<HospitalDoctorTab> {
  late Query dbRef;
  late StreamController<List<Map>> _streamController;
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    getHospitalData();
  }

  void getHospitalData() {
    _streamController = StreamController<List<Map>>();
    dbRef =
        FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospitalDoctor');
    dbRef
        .orderByChild("Hospital_ID")
        .equalTo(widget.hospitalKey)
        .onValue
        .listen((event) {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      List<Map> hospitals = [];
      logger.d(hospitals);
      if (values != null) {
        values.forEach((key, value) {
          if (value['Photo'] != null && value['Photo'].toString().isNotEmpty) {
          } else {
            hospitals.add({
              'DoctorName': value['Doctor'],
              'Hospital_ID': value['Hospital_ID'],
              "TimeFrom": value["TimeFrom"],
              "TimeTo": value["TimeTo"]
            });
          }
        });
      }
      logger.d(hospitals);
      _streamController.add(hospitals);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<List<Map>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Map>? hospitals = snapshot.data;
                if (hospitals != null && hospitals.isNotEmpty) {
                  return ListView.builder(
                    itemCount: hospitals.length,
                    itemBuilder: (context, index) {
                      Map data1 = hospitals[index];
                      var time = "${data1["TimeFrom"]} - ${data1["TimeTo"]}";
                      return ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        // leading: Image.network(imagePath),
                        title: Text(data1['DoctorName'].toString()),
                        subtitle: Text(time),
                        onTap: () {},
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No hospitals found'));
                }
              }
            },
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HospitalDoctorAdd(),
              ),
            );
          },
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
