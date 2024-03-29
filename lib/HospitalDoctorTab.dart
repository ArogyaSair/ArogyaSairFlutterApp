// ignore_for_file: file_names

import 'dart:async';

import 'package:arogyasair/hospitalDoctorAdd.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HospitalDoctorTab extends StatefulWidget {
  final String hospitalKey;

  const HospitalDoctorTab(this.hospitalKey, {super.key});

  @override
  State<HospitalDoctorTab> createState() => _HospitalDoctorTabState();
}

class _HospitalDoctorTabState extends State<HospitalDoctorTab> {
  late Query dbRef;
  late StreamController<List<Map>> _streamController;
  var logger = Logger();
  late var imagePath;
  Map<dynamic, dynamic>? doctorData;
  Map<int, dynamic> doctorMap = {};
  List<Map> hospitals = [];

  @override
  void initState() {
    super.initState();
    getHospitalData();
  }

  Future<void> fetchUserData(String key, int index) async {
    imagePath =
        "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/DoctorImage%2FDefaultProfileImage.png?alt=media";
    DatabaseReference dbUserData = FirebaseDatabase.instance
        .ref()
        .child("ArogyaSair/tblDoctor")
        .child(key);
    DatabaseEvent userDataEvent = await dbUserData.once();
    DataSnapshot userDataSnapshot = userDataEvent.snapshot;
    doctorData = userDataSnapshot.value as Map?;
    doctorMap[index] = {
      "DoctorName": doctorData!["DoctorName"],
      "Speciality": doctorData?["Speciality"],
      "Photo": doctorData?["Photo"],
    };
    _streamController.add(hospitals); // Update the stream with new data
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
      if (values != null) {
        values.forEach((key, value) async {
          var doctorId = value["Doctor"];
          print("doctor id $doctorId");
          hospitals.add({
            'DoctorName': value['Doctor'],
            'Hospital_ID': value['Hospital_ID'],
            "TimeFrom": value["TimeFrom"],
            "TimeTo": value["TimeTo"],
          });
          await fetchUserData(doctorId, hospitals.length - 1);
        });
      }
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
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Map data1 = hospitals[index];
                      var time = "${data1["TimeFrom"]} - ${data1["TimeTo"]}";
                      print("doctorMap $index ${doctorMap[index]}");
                      if (doctorMap[index]["Photo"] != null &&
                          doctorMap[index]["Photo"] != "") {
                        imagePath =
                            "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/DoctorImage%2F${doctorMap[index]["Photo"]}?alt=media";
                      }
                      if (doctorMap.isNotEmpty) {
                        return SizedBox(
                          child: Card(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    imagePath,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                    doctorMap[index]["DoctorName"].toString()),
                                subtitle: Text(time),
                                onTap: () {},
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                } else {
                  return const Center(child: Text('No doctors found'));
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
