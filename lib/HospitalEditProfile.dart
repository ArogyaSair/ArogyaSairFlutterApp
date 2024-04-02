// ignore_for_file: file_names, non_constant_identifier_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables  import 'dart:html';, use_build_context_synchronously
import 'dart:io';

import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_holo_date_picker/date_picker.dart';
// import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class HospitalEditProfile extends StatefulWidget {
  const HospitalEditProfile({super.key});

  @override
  State<HospitalEditProfile> createState() => _HospitalEditProfileState();
}

class _HospitalEditProfileState extends State<HospitalEditProfile> {
  var imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2FArogyaSair.png?alt=media";
  late Query Ref;
  late Map data;
  late TextEditingController controllerAddress;
  late TextEditingController controllerName;
  late TextEditingController controllerMail;
  late TextEditingController controllerDateOfBirth;
  late TextEditingController controllerBloodGroup;
  var birthDate = "Select Birthdate";
  var selectedValue = 0;

  // var selectedGender;
  late String username;
  late String userKey;
  late String fileName;
  String imageName = "";
  late String email;
  final key = 'HospitalName';
  final key1 = 'HospitalEmail';
  File? _image; // Make _image nullable

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        fileName = basename(_image!.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Edit Profile',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // If the Future is complete, show the actual UI
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Update Hospital Information",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: _image != null
                              ? Image.file(_image!,
                                  height: 110, width: 110, fit: BoxFit.cover)
                              : Image.network(
                                  imagePath,
                                  height: 110,
                                  width: 110,
                                ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.cloud_upload,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Upload Image",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff12d3c6)),
                          onPressed: () {
                            getImage();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: controllerName,
                      decoration: const InputDecoration(
                        hintText: "Name",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xff12d3c6),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: controllerMail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email Address",
                        prefixIcon: Icon(Icons.mail, color: Color(0xff12d3c6)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: controllerAddress,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Address",
                        prefixIcon:
                            Icon(Icons.pin_drop, color: Color(0xff12d3c6)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        updateData(userKey);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff12d3c6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
        future: _loadUserData(),
      ),
    );
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
        .child("ArogyaSair/tblHospital")
        .orderByChild("Email")
        .equalTo(email);

    await Ref.once().then((documentSnapshot) async {
      for (var x in documentSnapshot.snapshot.children) {
        data = x.value as Map;
        controllerName = TextEditingController(text: data["HospitalName"]);
        controllerAddress =
            TextEditingController(text: data["HospitalAddress"]);
        controllerMail = TextEditingController(text: data["Email"]);
        controllerDateOfBirth = TextEditingController();
        controllerBloodGroup = TextEditingController();
        if (data["Photo"] != null) {
          imagePath =
              "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2F${data["Photo"]}?alt=media";
          imageName = data["Photo"];
        }
      }
    });
  }

  Future uploadImage() async {
    fileName = basename(_image!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("HospitalImage/$fileName");
    firebaseStorageRef.putFile(_image!);
  }

  void updateData(String userkey) async {
    if (_image != null) {
      final updatedData = {
        "HospitalName": controllerName.text,
        "Email": controllerMail.text,
        "Photo": fileName,
      };
      uploadImage();
      if (imageName != "") {
        final desertRef =
            FirebaseStorage.instance.ref("HospitalImage/$imageName");
        await desertRef.delete();
      }
      final userRef = FirebaseDatabase.instance
          .ref()
          .child("ArogyaSair/tblHospital")
          .child(userkey);
      await userRef.update(updatedData);
      saveData(key, controllerName.text);
    } else {
      final updatedData = {
        "HospitalName": controllerName.text,
        "Email": controllerMail.text,
      };
      final userRef = FirebaseDatabase.instance
          .ref()
          .child("ArogyaSair/tblHospital")
          .child(userkey);
      await userRef.update(updatedData);
    }
    saveData(key, controllerName.text);
    Navigator.pop(this.context);
  }
}
