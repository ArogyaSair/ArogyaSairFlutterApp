// ignore_for_file: file_names

import 'dart:async';

import 'package:arogyasair/hospitalPackagesAdd.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'HospitalPackageInformation.dart';

class HospitalPackagesTab extends StatefulWidget {
  final String hospitalKey;

  const HospitalPackagesTab(this.hospitalKey, {Key? key}) : super(key: key);

  @override
  State<HospitalPackagesTab> createState() => _HospitalPackagesTabState();
}

class _HospitalPackagesTabState extends State<HospitalPackagesTab> {
  late Query dbRef;
  late StreamController<List<Map>> _streamController;
  late String hospitalKey;
  late String hospitalName;
  late bool containsKey;

  @override
  void initState() {
    super.initState();
    getHospitalData();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? userData = await getKey();
    String? userName = await getData("HospitalName");
    setState(() {
      hospitalKey = userData!;
      hospitalName = userName!;
    });
  }

  void getHospitalData() {
    _streamController = StreamController<List<Map>>();
    dbRef = FirebaseDatabase.instance.ref().child('ArogyaSair/tblPackages');
    dbRef
        .orderByChild("HospitalName")
        .equalTo(widget.hospitalKey)
        .onValue
        .listen((event) {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      List<Map> hospitals = [];
      if (values != null) {
        values.forEach((key, value) {
          if (value['Photo'] != null && value['Photo'].toString().isNotEmpty) {
            hospitals.add({
              'ID': key,
              'PackageName': value['PackageName'],
              'Duration': value['Duration'],
              'Photo': value["Photo"],
            });
          } else {
            hospitals.add({
              'ID': key,
              'PackageName': value['PackageName'],
              'Duration': value['Duration'],
              'Photo': 'DefaultProfileImage.png',
            });
          }
        });
      }
      _streamController.add(hospitals);
    });
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
                List<Map>? hospitals = snapshot.data;
                if (hospitals != null && hospitals.isNotEmpty) {
                  return ListView.builder(
                    itemCount: hospitals.length,
                    itemBuilder: (context, index) {
                      Map data1 = hospitals[index];
                      var imageName = data1['Photo'] == ''
                          ? 'DefaultProfileImage.png'
                          : "PackageImage%2F${data1['Photo']}";
                      var imagePath = data1['Photo'] == 'noImage'
                          ? 'https://via.placeholder.com/150'
                          : "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/$imageName?alt=media";
                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              imagePath,
                              height: 100,
                              width: 100,
                            ),
                          ),
                          title: Text(data1['PackageName'].toString()),
                          subtitle:
                              Text("${data1['Duration'].toString()} weeks"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PackageInformation(
                                    hospitalName,
                                    hospitals[index]["ID"].toString()),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No hospitals found'));
                }
              }
            },
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (containsKey) =>
                        HospitalPackageAdd(hospitalKey: hospitalKey)));
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.blue),
          ),
        ),
      ),
    );
  }
}
