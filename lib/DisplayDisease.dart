// import 'package:arogyasair/temp.dart';
// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'models/DiseaseModel.dart';

class DisplayDisease extends StatefulWidget {
  const DisplayDisease({super.key});

  @override
  State<DisplayDisease> createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<DisplayDisease> {
  final List<String> items = [
    'Atrial fibrillation ',
    'Cardiomyopathy',
    'Peripheral vascular disease'
  ]; // Your data source

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Disease",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
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
          padding: const EdgeInsets.all(1),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child("ArogyaSair/tblDisease")
                  .onValue,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
                  List<DiseaseData> diseaseList = [];
                  diseaseList.clear();
                  map.forEach((key, value) {
                    diseaseList.add(DiseaseData.fromMap(value, key));
                  });
                  return ListView.builder(
                    itemCount: diseaseList.length,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Card(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(diseaseList[index].diseaseName),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => HospitalPackagesTab(
                          //       item: items[index],
                          //     ),
                          //   ),
                          // );
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
    );
  }
}
