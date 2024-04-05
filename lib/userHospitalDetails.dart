// ignore_for_file: file_names, non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HospitalDetails extends StatefulWidget {
  final String hospitalKey;

  const HospitalDetails({super.key, required this.hospitalKey});

  @override
  State<HospitalDetails> createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails> {
  var imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/UserImage%2FDefaultProfileImage.png?alt=media";
  late Query Ref;
  late Map data;
  late String controllerName;
  late String controllerUsername;
  late String controllerMail;
  late String controllerDateOfBirth;
  late String controllerBloodGroup;
  late String username;
  late String userKey;
  late String fileName;
  String imageName = "";
  late String email;
  final key = 'username';
  final key1 = 'email';

  Future<void> _loadUserData() async {
    Query Ref = FirebaseDatabase.instance
        .ref()
        .child("ArogyaSair/tblHospital")
        .orderByChild("Email")
        .equalTo(widget.hospitalKey);

    await Ref.once().then((documentSnapshot) async {
      for (var x in documentSnapshot.snapshot.children) {
        data = x.value as Map;
        controllerUsername = data["HospitalAddress"];
        controllerName = data["HospitalName"];
        controllerMail = data["Email"];
        controllerDateOfBirth = data["HospitalCity"];
        controllerBloodGroup = data["HospitalState"];
        if (data["Photo"] != null) {
          imagePath =
              "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2F${data["Photo"]}?alt=media";
          imageName = data["Photo"];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff12d3c6),
              title: const Text(
                'View Hospital',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors
                                        .grey, // Change background color here
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(imagePath),
                                    radius: 35, // Adjust the size of the image
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Profile Information',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            ListTile(
                              leading: const Icon(
                                Icons.email,
                                color: Color(0xff12d3c6),
                              ),
                              title: const Text(
                                'Email',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(controllerMail),
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            ListTile(
                              leading: const Icon(
                                Icons.local_hospital,
                                color: Color(0xff12d3c6),
                              ),
                              title: const Text(
                                'Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(controllerName),
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            ListTile(
                              leading: const Icon(
                                Icons.pin_drop,
                                color: Color(0xff12d3c6),
                              ),
                              title: const Text(
                                'Address',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(controllerUsername),
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            ListTile(
                              leading: const Icon(
                                Icons.location_on,
                                color: Color(0xff12d3c6),
                              ),
                              title: const Text(
                                'State',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(controllerBloodGroup),
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            ListTile(
                              leading: const Icon(
                                Icons.location_city,
                                color: Color(0xff12d3c6),
                              ),
                              title: const Text(
                                'City',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(controllerDateOfBirth),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
      future: _loadUserData(),
    );
  }
}
