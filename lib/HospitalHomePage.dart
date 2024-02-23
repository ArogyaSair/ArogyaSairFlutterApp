// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'HospitalSideDrawer.dart';
import 'PackageInformation.dart';
import 'models/HomePageModel.dart';
import 'models/HospitalDoctorModel.dart';

class HospitalHomePage extends StatefulWidget {
  const HospitalHomePage({Key? key}) : super(key: key);

  @override
  _HospitalHomePage createState() => _HospitalHomePage();
}

class _HospitalHomePage extends State<HospitalHomePage> {
  Query dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospital');
  late String data;
  final key = 'username';
  late bool containsKey;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? userData = await getData(key);
    setState(() {
      data = userData!;
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
          'Arogya Sair',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      endDrawer: HospitalDrawerCode(),
      body: Column(
        children: [
          // Generated code for this Container Widget..
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 150,
              width: 400,
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
                    List<HomeData> hospitalList = [];
                    hospitalList.clear();
                    map.forEach((key, value) {
                      hospitalList.add(HomeData.fromMap(value, key));
                    });
                    return GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              // childAspectRatio: 10,
                              crossAxisCount: 1),
                      itemCount: hospitalList.length,
                      padding: const EdgeInsets.all(2.0),
                      itemBuilder: (BuildContext context, int index) {
                        if (hospitalList[index].hospitalImage == null) {
                          imagePath =
                              "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2FArogyaSair.png?alt=media";
                        } else {
                          imagePath =
                              "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2F${hospitalList[index].hospitalImage}?alt=media";
                        }
                        return GestureDetector(
                          onTap: () {
                            final key = hospitalList[index].id;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PackageInformation(key1: key),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 15,
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
                                          hospitalList[index].hospitalName,
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
            child: SizedBox(
              height: 150,
              width: 400,
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
                            final key = doctorList[index].id;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PackageInformation(key1: key),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 15,
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
        ],
      ),
    );
  }
}
