// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import 'drawerSideNavigation.dart';

class MyHistory extends StatefulWidget {
  const MyHistory({super.key});

  @override
  _MyHistoryState createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  late String imagePath;
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
        FirebaseDatabase.instance.ref().child('ArogyaSair/tblTreatment');
    DatabaseEvent event = await dbRef.once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value == null) {
      return Appointments;
    }

    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

    values.forEach((key, value) async {
      if (value["Status"] == "Complete") {
        Appointments.add({
          'HospitalName': value['HospitalID'],
          'Key': key,
          'AppointmentDate': value["DateOfAppointment"],
          'Disease': value["Disease"],
          'Status': value["Status"],
          'UserId': value["PatientID"],
          'DoctorName': value["DoctorName"],
        });
        await fetchUserData(value["HospitalID"], Appointments.length - 1);
        dataFetched = true;
      }
    });
    return Appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff2f6f7),
        automaticallyImplyLeading: false,
        title: const Text(
          'Appointment History',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xff12d3c6)),
      ),
      endDrawer: const DrawerCode(),
      body: Container(
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
                if (Appointments.isNotEmpty) {
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        const FaIcon(
                                            FontAwesomeIcons.userDoctor),
                                        const SizedBox(width: 20),
                                        Text(
                                          Appointments[index]["DoctorName"],
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          Appointments[index]["Disease"],
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          Appointments[index]
                                              ["AppointmentDate"],
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Positioned(
                              top: 5,
                              right: 5,
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Color(0xff12d3c6),
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
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
                          'No history found',
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          //
        ),
      ),
    );
  }
}
