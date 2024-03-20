// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'GenaralAppointmentDateSelection.dart';
import 'models/HospitalModel.dart';

class DisplayHospitals extends StatefulWidget {
  const DisplayHospitals({super.key});

  @override
  State<DisplayHospitals> createState() => _DisplayHospitalsState();
}

class _DisplayHospitalsState extends State<DisplayHospitals> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade500,
              Colors.green.shade400,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              "Hospitals",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue.shade900,
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: StreamBuilder(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child("ArogyaSair/tblHospital")
                    .onValue,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
                    List<HospitalData> hospitalList = [];
                    hospitalList.clear();
                    map.forEach((key, value) {
                      hospitalList.add(HospitalData.fromMap(value, key));
                    });

                    return ListView.builder(
                      itemCount: hospitalList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                hospitalList[index].hospitalName,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          onTap: () {
                            // String disease= "General Checkup";
                            // Navigate to a new page on item click
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GeneralAppointmentDateSelection(
                                  HospitalName:
                                      hospitalList[index].hospitalName,
                                  HospitalKey: hospitalList[index].id,
                                  item: "General Checkup",
                                ), // Pass data to the new page
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
