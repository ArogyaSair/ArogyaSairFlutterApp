// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserApprovedData extends StatefulWidget {
  final String userKey;
  final String userName;

  const UserApprovedData(this.userKey, this.userName, {super.key});

  @override
  _UserApprovedDataState createState() => _UserApprovedDataState();
}

class _UserApprovedDataState extends State<UserApprovedData> {
  late String imagePath;
  late String date;
  List<Map> Appointments = [];
  late String packageImagePath;
  Map<dynamic, dynamic>? userData;
  Map<int, Map> userMap = {};
  late Map data2;
  bool dataFetched = false; // Flag to track if data has been fetched

  Future<void> fetchUserData(String key, int index) async {
    DatabaseReference dbUserData = FirebaseDatabase.instance
        .ref()
        .child("ArogyaSair/tblHospital")
        .child(key);
    DatabaseEvent userDataEvent = await dbUserData.once();
    DataSnapshot userDataSnapshot = userDataEvent.snapshot;
    userData = userDataSnapshot.value as Map?;
    userMap[index] = {
      "Key": userDataSnapshot.key,
      "HospitalName": userData!["HospitalName"],
    };
    setState(() {});
  }

  Future<List<Map>> getPackagesData() async {
    if (dataFetched) {
      return Appointments; // Return if data has already been fetched
    }
    DatabaseReference dbRef =
        FirebaseDatabase.instance.ref().child('ArogyaSair/tblAppointment');
    DatabaseEvent event = await dbRef.once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value == null) {
      return Appointments;
    }

    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

    values.forEach((key, value) async {
      if (value["Status"] == "Approved") {
        Appointments.add({
          'HospitalName': value['HospitalId'],
          'Key': key,
          'AppointmentDate': value["AppointmentDate"],
          'Disease': value["Disease"],
          'Status': value["Status"],
          'UserId': value["UserId"],
        });
        await fetchUserData(value["HospitalId"], Appointments.length - 1);
        dataFetched = true;
      }
    });
    return Appointments;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: FutureBuilder<List<Map>>(
          future: getPackagesData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              if (Appointments.isNotEmpty && userMap.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: Appointments.length,
                  itemBuilder: (context, index) {
                    data2 = userMap[index]!;
                    return Card(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      const FaIcon(FontAwesomeIcons.hospital),
                                      const SizedBox(width: 20),
                                      Text(
                                        "${data2['HospitalName']}",
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        Appointments[index]["Disease"],
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        Appointments[index]["AppointmentDate"],
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  " A ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (userMap.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(
                    child: Text('No Approved appointments found'));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        //
      ),
    );
  }
}
