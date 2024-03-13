// ignore_for_file: camel_case_types

import 'package:arogyasair/models/HomePageModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class get_hospital_data extends StatefulWidget {
  const get_hospital_data({super.key});

  @override
  State<get_hospital_data> createState() => _get_home_dataState();
}

class _get_home_dataState extends State<get_hospital_data> {
  late String imagePath;
  Map<dynamic, dynamic>? userData;
  Map<int, Map> userMap = {};
  late Map data2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: SizedBox(
        height: 140,
        width: double.infinity,
        child: StreamBuilder(
          stream: FirebaseDatabase.instance
              .ref()
              .child("ArogyaSair/tblHospital")
              .onValue,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
              List<HomeData> packagesList = [];
              packagesList.clear();
              map.forEach((key, value) {
                packagesList.add(HomeData.fromMap(value, key));
              });
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 0.35),
                itemCount: packagesList.length,
                padding: const EdgeInsets.all(2),
                itemBuilder: (BuildContext context, int index) {
                  if (packagesList[index].hospitalImage == "") {
                    imagePath =
                        "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2FArogyaSair.png?alt=media";
                  } else {
                    imagePath =
                        "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2F${packagesList[index].hospitalImage}?alt=media";
                  }
                  return Card(
                      child: Row(
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              imagePath,
                              height: 120,
                              width: 120,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(packagesList[index].hospitalName),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(packagesList[index].hospitalEmail),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Container(
                                height: 44.0,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xFF0D47A1),
                                      Colors.lightBlue
                                    ]),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              )),
                        ],
                      ),
                    ],
                  ));
                },
              );
            } else {
              return const CircularProgressIndicator(
                backgroundColor: Colors.redAccent,
                valueColor: AlwaysStoppedAnimation(Colors.green),
                strokeWidth: 1.5,
              );
            }
          },
        ),
      ),
    );
  }
}
