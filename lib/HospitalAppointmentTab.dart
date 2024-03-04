// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:arogyasair/HospitalAppointmentDetail.dart';
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
  Map<int, Map> userMap = {};
  late Map data1;
  late Map data2;
  late List<Map> userName = [];

  var logger = Logger();
  List<Map> appointment = [];
  String imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2FArogyaSair.png?alt=media";

  @override
  void initState() {
    super.initState();
    getHospitalData();
  }

  Future<void> getHospitalData() async {
    _streamController = StreamController<List<Map>>();
    dbRef = FirebaseDatabase.instance.ref().child('ArogyaSair/tblAppointment');
    dbRef
        .orderByChild("HospitalId")
        .equalTo(widget.hospitalKey)
        .onValue
        .listen((event) async {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        var userId;
        appointment.clear();
        userMap.clear();
        values.forEach((key, value) async {
          userId = value["UserId"];
          if (value['Status'] == 'Pending') {
            appointment.add({
              'Key': key,
              'AppointmentDate': value['AppointmentDate'],
              'HospitalID': value['HospitalId'],
              "Status": value["Status"],
              "UserId": value["UserId"],
              "Disease": value["Disease"]
            });
            await fetchUserData(userId, appointment.length - 1);
          }
        });
      }
      _streamController.add(appointment);
    });
  }

  Future<void> fetchUserData(String key, int index) async {
    DatabaseReference dbUserData =
        FirebaseDatabase.instance.ref().child("ArogyaSair/tblUser").child(key);
    DatabaseEvent userDataEvent = await dbUserData.once();
    DataSnapshot userDataSnapshot = userDataEvent.snapshot;
    userData = userDataSnapshot.value as Map?;
    userMap[index] = {
      "Key": userDataSnapshot.key,
      "UserName": userData!["Name"],
      "BloodGroup": userData!["BloodGroup"],
      "DateOfBirth": userData!["DOB"],
      "Gender": userData!["Gender"],
      "Email": userData!["Email"],
      "ContactNumber": userData!["ContactNumber"],
    };
    _streamController.add(appointment); // Update the stream with new data
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
                      data2 = userMap[index] ?? {};
                      var date = "${data1["AppointmentDate"]}";
                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Patient Name : ${data2['UserName']}"),
                              const SizedBox(width: 10),
                              Text("Requested date of visit : $date"),
                              const SizedBox(width: 10),
                              Text("For : ${data1["Disease"]}"),
                              const SizedBox(width: 10),
                              Text("Request status : ${data1["Status"]}"),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HospitalAppointmentDetail(
                                  appointment[index],
                                  userMap[index],
                                  widget.hospitalKey,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                      child: Text('No Pending Appointments Available'));
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
