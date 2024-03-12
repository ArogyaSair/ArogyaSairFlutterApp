// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:io';

import 'package:arogyasair/HospitalHomePage.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class HospitalRegisterImageAdd extends StatefulWidget {
  const HospitalRegisterImageAdd({super.key});

  @override
  State<HospitalRegisterImageAdd> createState() =>
      _HospitalRegisterImageAddState();
}

class _HospitalRegisterImageAddState extends State<HospitalRegisterImageAdd> {
  var imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/UserImage%2FDefaultProfileImage.png?alt=media";

  File? _image;
  late Query Ref;
  late String fileName;
  String imageName = "";
  late String userKey;

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
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Center(
              child: Image.asset(
                'assets/Logo/ArogyaSair.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _image != null
                      ? Image.file(_image!,
                      height: 150, width: 150, fit: BoxFit.cover)
                      : Image.network(
                    imagePath,
                    height: 150,
                    width: 150,
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
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    getImage();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: ElevatedButton(
              onPressed: () {
                updateData(userKey);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HospitalHomePage(0)));
              },
              child: const Text("Add Image"),
            ),
          )
        ],
      ),
    );
  }

  Future uploadImage() async {
    fileName = basename(_image!.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child("HospitalImage/$fileName");
    firebaseStorageRef.putFile(_image!);
  }

  Future<void> _loadUserData() async {
    String? userkey = await getKey();
    userKey = userkey!;
  }

  void updateData(String userkey) async {
    if (_image != null) {
      final updatedData = {
        "Photo": fileName,
      };
      if (imageName != "") {
        final desertRef =
        FirebaseStorage.instance.ref("HospitalImage/$imageName");
        await desertRef.delete();
      }
      uploadImage();
      final hospitalRef = FirebaseDatabase.instance
          .ref()
          .child("ArogyaSair/tblHospital")
          .child(userkey);
      await hospitalRef.update(updatedData);
    }
  }
}
