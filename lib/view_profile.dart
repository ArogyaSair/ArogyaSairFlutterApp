// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:arogyasair/EditProfile.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  var imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/UserImage%2FDefaultProfileImage.png?alt=media";
  late Query Ref;
  late Map data;
  late String controllerUsername;
  late String controllerName;
  late String controllerMail;
  late String controllerDateOfBirth;
  late String controllerBloodGroup;
  var birthDate = "Select Birthdate";
  var selectedValue = 0;
  var selectedGender;
  late String username;
  late String userKey;
  late String fileName;
  String imageName = "";
  late String email;
  final key = 'username';
  final key1 = 'email';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? userData = await getData(key);
    String? userEmail = await getData(key1);
    String? userkey = await getKey();

    username = userData!;
    email = userEmail!;
    userKey = userkey!;

    Ref = FirebaseDatabase.instance
        .ref()
        .child("ArogyaSair/tblUser")
        .orderByChild("Username")
        .equalTo(username);

    await Ref.once().then((documentSnapshot) async {
      for (var x in documentSnapshot.snapshot.children) {
        data = x.value as Map;
        controllerUsername = data["Username"];
        controllerName = data["Name"];
        controllerMail = data["Email"];
        controllerDateOfBirth = data["DOB"];
        controllerBloodGroup = data["BloodGroup"];
        selectedGender ??= data["Gender"];
        if (data["Photo"] != null) {
          imagePath =
              "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/UserImage%2F${data["Photo"]}?alt=media";
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
              backgroundColor: Colors.blue.shade900,
              title: const Text(
                'View Profile',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfile(),
                        ),
                      );
                    },
                    icon: const FaIcon(FontAwesomeIcons.userPen))
              ],
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
                            const Divider(height: 30, color: Colors.grey),
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text(
                                'Username',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(controllerUsername),
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            ListTile(
                              leading: const Icon(Icons.email),
                              title: const Text(
                                'Email',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(controllerMail),
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text(
                                'Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(controllerName),
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            ListTile(
                              leading: const Icon(Icons.wc),
                              title: const Text(
                                'Gender',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(selectedGender),
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            ListTile(
                              leading: const Icon(Icons.favorite),
                              title: const Text(
                                'Blood Group',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(controllerBloodGroup),
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            ListTile(
                              leading: const Icon(Icons.cake),
                              title: const Text(
                                'Date of Birth',
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
