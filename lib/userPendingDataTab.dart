// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class UserPendingData extends StatefulWidget {
  final String userKey;
  final String userName;

  const UserPendingData(this.userKey, this.userName, {super.key});

  @override
  _UserPendingDataState createState() => _UserPendingDataState();
}

class _UserPendingDataState extends State<UserPendingData> {
  late String imagePath;
  List<Map> appointments = [];
  late String packageImagePath;
  Map<dynamic, dynamic>? userData;
  Map<int, Map> userMap = {};
  late Map data2;
  late String userId;
  bool dataFetched = false; // Flag to track if data has been fetched

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    String? userid = await getKey();
    setState(() {
      userId = userid!;
    });
  }

  Future<void> fetchUserData(String key, int index) async {
    userMap.clear();
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
      return appointments; // Return if data has already been fetched
    }
    DatabaseReference dbRef =
        FirebaseDatabase.instance.ref().child('ArogyaSair/tblAppointment');
    DatabaseEvent event = await dbRef.once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value == null) {
      return appointments;
    }

    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

    appointments.clear();
    values.forEach((key, value) async {
      if (value["Status"] == "Pending" && value["UserId"] == userId) {
        appointments.add({
          'HospitalName': value['HospitalId'],
          'Key': key,
          'AppointmentDate': value["AppointmentDate"],
          'Disease': value["Disease"],
          'Status': value["Status"],
          'UserId': value["UserId"],
        });
        await fetchUserData(value["HospitalId"], appointments.length - 1);
        dataFetched = true;
      }
    });
    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff2f6f7),
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: FutureBuilder<List<Map>>(
          future: getPackagesData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              if (appointments.isNotEmpty && userMap.isNotEmpty) {
                return ListView.builder(
                  // shrinkWrap: true,
                  itemCount: appointments.length,
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
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        appointments[index]["Disease"],
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        appointments[index]["AppointmentDate"],
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
                                color: const Color(0xff12d3c6),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.hourglass_bottom,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if(appointments.isEmpty) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/Animation/no_data_found.json',
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.3,
                        // repeat: false,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No pending appointments found',
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else{
                return const Center(child: CircularProgressIndicator(),);
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
