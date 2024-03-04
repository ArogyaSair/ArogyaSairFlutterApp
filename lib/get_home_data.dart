// ignore_for_file: camel_case_types

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'models/HomePageModel.dart';

class get_home_data extends StatefulWidget {
  const get_home_data({Key? key}) : super(key: key);

  @override
  State<get_home_data> createState() => _get_home_dataState();
}

class _get_home_dataState extends State<get_home_data> {
  late String imagePath;

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
              List<HomeData> hospitalList = [];
              hospitalList.clear();
              map.forEach((key, value) {
                hospitalList.add(HomeData.fromMap(value, key));
              });
              return GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 0.35),
                itemCount: hospitalList.length,
                padding: const EdgeInsets.all(2),
                itemBuilder: (BuildContext context, int index) {
                  if (hospitalList[index].hospitalImage == "") {
                    imagePath =
                        "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2FArogyaSair.png?alt=media";
                  } else {
                    imagePath =
                        "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2F${hospitalList[index].hospitalImage}?alt=media";
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
                            child: Text(hospitalList[index].hospitalName),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(hospitalList[index].hospitalEmail),
                          ),
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