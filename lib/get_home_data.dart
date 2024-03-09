// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:async';

import 'package:arogyasair/models/userPackagebookinginformation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'PackageDetails.dart';

class get_home_data extends StatefulWidget {
  const get_home_data({Key? key}) : super(key: key);

  @override
  State<get_home_data> createState() => _get_home_dataState();
}

class _get_home_dataState extends State<get_home_data> {
  late String imagePath;
  late String packageImagePath;
  Map<dynamic, dynamic>? userData;
  Map<int, Map> userMap = {};

  // late StreamController<List<Map>> _streamController;
  List<Map> Package = [];
  late Map data2;

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
    // _streamController.add(Package); // Update the stream with new data
  }

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
              .child("ArogyaSair/tblPackages")
              .onValue,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
              List<UserPackageData> packagesList = [];
              packagesList.clear();
              map.forEach((key, value) {
                fetchUserData(value["HospitalName"], packagesList.length);
                packagesList.add(UserPackageData.fromMap(value, key));
              });
              return GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 0.35),
                itemCount: packagesList.length,
                padding: const EdgeInsets.all(2),
                itemBuilder: (BuildContext context, int index) {
                  data2 = userMap[index] ?? {};
                  if (packagesList[index].image == "") {
                    packageImagePath =
                        "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/PackageImage%2FDefaultProfileImage.png?alt=media";
                  } else {
                    packageImagePath =
                        "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/PackageImage%2F${packagesList[index].image}?alt=media";
                  }
                  return Card(
                      child: Row(
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              packageImagePath,
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
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(packagesList[index].packagename),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(packagesList[index].price),
                          ),
                          Text("${data2['HospitalName']}"),
                          Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                height: 44.0,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xFF0D47A1),
                                      Colors.lightBlue
                                    ]),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (packagesList[index].image == "") {
                                      packageImagePath =
                                          "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/PackageImage%2FDefaultProfileImage.png?alt=media";
                                    } else {
                                      packageImagePath =
                                          "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/PackageImage%2F${packagesList[index].image}?alt=media";
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PackageDetails(
                                          PackageName:
                                              packagesList[index].packagename,
                                          Price: packagesList[index].price,
                                          HospitalName: data2['HospitalName'],
                                          Duration:
                                              packagesList[index].Duration,
                                          Incude: packagesList[index].include,
                                          Image: packageImagePath,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    'View',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ));
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
    );
  }
}
