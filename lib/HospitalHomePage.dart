// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'HospitalPackageInformation.dart';
import 'HospitalSideDrawer.dart';
import 'models/HospitalDoctorModel.dart';
import 'models/PackageDataModel.dart';

class HospitalHomePage extends StatefulWidget {
  const HospitalHomePage({Key? key}) : super(key: key);

  @override
  _HospitalHomePage createState() => _HospitalHomePage();
}

class _HospitalHomePage extends State<HospitalHomePage> {
  Query dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospital');
  late String hospitalName;
  final key = 'HospitalName';
  late bool containsKey;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? userData = await getData(key);
    setState(() {
      hospitalName = userData!;
    });
  }

  var imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2Faiims.jpeg?alt=media";

  // List<FacilityData> _selectedAnimals2 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Text(
          'AS Hospital',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      endDrawer: HospitalDrawerCode(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 170,
              width: 400,
              child: StreamBuilder(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child("ArogyaSair/tblPackages")
                    .onValue,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
                    List<PackageData> packageList = [];
                    packageList.clear();
                    map.forEach((key, value) {
                      packageList.add(PackageData.fromMap(value, key));
                    });
                    return GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1),
                      itemCount: packageList.length,
                      padding: const EdgeInsets.all(2.0),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            final key = packageList[index].id;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    // work
                                    PackageInformation(hospitalName, key),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: 200,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15.0)),
                                  image: DecorationImage(
                                    image: NetworkImage(imagePath),
                                    fit: BoxFit.cover,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.blue,
                                          Color(0x19000000)
                                        ],
                                        begin: FractionalOffset(0.0, 1.0),
                                        end: FractionalOffset(0.0, 0.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          packageList[index].packagename,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
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
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 150,
              width: 500,
              child: StreamBuilder(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child("ArogyaSair/tblDoctor")
                    .onValue,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
                    List<HospitalDoctorData> doctorList = [];
                    doctorList.clear();
                    map.forEach((key, value) {
                      doctorList.add(HospitalDoctorData.fromMap(value, key));
                    });
                    return GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                      itemCount: doctorList.length,
                      padding: const EdgeInsets.all(2.0),
                      itemBuilder: (BuildContext context, int index) {
                        if (doctorList[index].doctorImage == null) {
                          imagePath =
                          "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/DoctorImage%2FArogyaSair.png?alt=media";
                        } else {
                          imagePath =
                          "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/DoctorImage%2F${doctorList[index].doctorImage}?alt=media";
                        }
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         // PackageInformation(key1: key, HospitlName: '',),
                            //   ),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: (MediaQuery.of(context).size.width),
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15.0)),
                                  image: DecorationImage(
                                    image: NetworkImage(imagePath),
                                    fit: BoxFit.cover,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                // child: Text(hospitalList[index].pname),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.blue,
                                          Color(0x19000000)
                                        ],
                                        begin: FractionalOffset(0.0, 1.0),
                                        end: FractionalOffset(0.0, 0.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          doctorList[index].doctorName,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
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
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 200,
                  width: 400,
                  child: StreamBuilder(
                    stream: FirebaseDatabase.instance
                        .ref()
                        .child("ArogyaSair/tblDoctor")
                        .onValue,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data!.snapshot.value != null) {
                        Map<dynamic, dynamic> map =
                            snapshot.data!.snapshot.value;
                        List<HospitalDoctorData> doctorList = [];
                        doctorList.clear();
                        map.forEach((key, value) {
                          doctorList
                              .add(HospitalDoctorData.fromMap(value, key));
                        });
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: doctorList.length,
                          padding: const EdgeInsets.all(2.0),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     // builder: (context) => PackageInformation(key1: key, HospitlName: '',),
                                //   ),
                                // );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    // Display doctor image if available

                                    const SizedBox(width: 10.0), // Add spacing

                                    // Column for doctor details and buttons
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Doctor name
                                          Text(
                                            doctorList[index].doctorName,
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 5.0),
                                          // Add spacing

                                          // Row for buttons
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Button 1
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Add functionality for Button 1
                                                },
                                                child: const Text("Button 1"),
                                              ),
                                              // Button 2
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Add functionality for Button 2
                                                },
                                                child: const Text("Button 2"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
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
              ))
        ],
      ),
    );
  }
}
