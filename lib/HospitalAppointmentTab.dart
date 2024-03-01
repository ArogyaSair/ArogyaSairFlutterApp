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
  late Query dbRef;
  late Query dbRefUser;
  late StreamController<List<Map>> _streamController;
  Map<dynamic, dynamic>? userData;
  late Map data1;

  var logger = Logger();
  List<Map> appointment = [];
  String imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2FArogyaSair.png?alt=media";

  @override
  void initState() {
    super.initState();
    getHospitalData();
    // fetchUserData(data1["UserId"]);
  }

  void getHospitalData() {
    _streamController = StreamController<List<Map>>();
    dbRef = FirebaseDatabase.instance.ref().child('ArogyaSair/tblAppointment');
    dbRef
        .orderByChild("HospitalId")
        .equalTo(widget.hospitalKey)
        .onValue
        .listen((event) {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        values.forEach((key, value) {
          appointment.add({
            'AppointmentDate': value['AppointmentDate'],
            'HospitalID': value['HospitalID'],
            "Status": value["Status"],
            "UserId": value["UserId"]
          });
        });
      }
      _streamController.add(appointment);
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
                List<Map>? appointment = snapshot.data;
                if (appointment != null && appointment.isNotEmpty) {
                  return ListView.builder(
                    itemCount: appointment.length,
                    itemBuilder: (context, index) {
                      data1 = appointment[index];
                      print(data1["UserId"]);
                      var time = "${data1["AppointmentDate"]}";
                      logger.d(userData?["Name"]);
                      var userName = fetchUserData(data1["UserId"]);
                      logger.d(userName);
                      return ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        title: Row(
                          children: [
                            Text(data1['Status'].toString()),
                            const SizedBox(width: 10),
                            Text(userName as String),
                          ],
                        ),
                        subtitle: Text(time),
                        onTap: () {},
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No appointment found'));
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Future<String> fetchUserData(String key) async {
    DatabaseReference dbUserData =
        FirebaseDatabase.instance.ref().child("ArogyaSair/tblUser").child(key);
    DatabaseEvent userDataEvent = await dbUserData.once();
    DataSnapshot userDataSnapshot = userDataEvent.snapshot;
    userData = userDataSnapshot.value as Map?;
    return userData!["Name"];
  }
}
