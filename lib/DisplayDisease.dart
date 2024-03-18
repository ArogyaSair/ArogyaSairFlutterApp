import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'HospitalSelection.dart';
import 'models/DiseaseModel.dart';

class DisplayDisease extends StatefulWidget {
  const DisplayDisease({super.key});

  @override
  State<DisplayDisease> createState() => _DisplayDiseaseState();
}

class _DisplayDiseaseState extends State<DisplayDisease> {
  //our data source

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
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: StreamBuilder(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child("ArogyaSair/tblDisease")
                    .onValue,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
                    List<DiseaseData> diseaseList = [];
                    diseaseList.clear();
                    map.forEach((key, value) {
                      diseaseList.add(DiseaseData.fromMap(value, key));
                    });
                    return ListView.builder(
                      itemCount: diseaseList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                diseaseList[index].diseaseName,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PackageHospitalSelection(
                                  diseaseList: diseaseList[index],
                                ),
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