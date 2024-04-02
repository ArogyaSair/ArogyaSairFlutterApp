// ignore_for_file: file_names, depend_on_referenced_packages, non_constant_identifier_names, unused_local_variable

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class HospitalPackageEdit extends StatefulWidget {
  final String hospitalName;
  final String packageKey;
  final Map packageData;

  const HospitalPackageEdit(
      this.hospitalName, this.packageKey, this.packageData,
      {super.key});

  @override
  State<HospitalPackageEdit> createState() => _HospitalPackageEditState();
}

class _HospitalPackageEditState extends State<HospitalPackageEdit> {
  var imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/PackageImage%2FDefaultProfileImage.png?alt=media";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Query Ref;
  late TextEditingController controllerPackageName;
  late TextEditingController controllerPackagePrice;
  late TextEditingController controllerPackageIncludes;
  late TextEditingController controllerHospitalName;
  late TextEditingController controllerPackageDuration;
  late String username;
  late String userKey;
  late String fileName;
  String imageName = "";
  late String email;
  final key = 'HospitalName';
  final key1 = 'email';
  Logger logger = Logger();
  File? _image;
  final picker = ImagePicker();
  late String packageKey;

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
    packageKey = widget.packageKey;
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Packages",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff12d3c6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                removePackages(packageKey, context);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: _image != null
                                ? Image.file(_image!,
                                    height: 100, fit: BoxFit.cover)
                                : Image.network(
                                    imagePath,
                                    height: 100,
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
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerPackageName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Package name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIconColor: Color(0xff12d3c6),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Package Name',
                        hintText: 'Package Name',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerPackagePrice,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter price';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIconColor: Color(0xff12d3c6),
                        prefixIcon: Icon(Icons.currency_rupee),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Package Price',
                        hintText: 'Package Price',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerPackageIncludes,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter tests and reports Package include';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIconColor: Color(0xff12d3c6),
                        prefixIcon: Icon(Icons.add),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Package includes',
                        hintText: 'Package includes',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerHospitalName,
                      enabled: false,
                      decoration: const InputDecoration(
                        prefixIconColor: Color(0xff12d3c6),
                        prefixIcon: Icon(Icons.local_hospital),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Hospital Name',
                        hintText: 'Hospital Name',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerPackageDuration,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Duration(in Weeks)';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIconColor: Color(0xff12d3c6),
                        prefixIcon: Icon(Icons.access_time),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Duration In Weeks',
                        hintText: 'Enter Duration in Weeks',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50),
                        elevation: 10,
                        backgroundColor: const Color(0xff12d3c6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          updateData(packageKey);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Update",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _loadUserData() async {
    controllerPackageName =
        TextEditingController(text: widget.packageData["PackageName"]);
    controllerPackagePrice =
        TextEditingController(text: widget.packageData["Price"]);
    controllerPackageIncludes =
        TextEditingController(text: widget.packageData["Include"]);
    controllerHospitalName = TextEditingController(text: widget.hospitalName);
    controllerPackageDuration =
        TextEditingController(text: widget.packageData["Duration"]);
    if (widget.packageData["Photo"] != null) {
      imagePath =
          "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/PackageImage%2F${widget.packageData["Photo"]}?alt=media";
      imageName = widget.packageData["Photo"];
    }
  }

  Future uploadImage() async {
    fileName = basename(_image!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("PackageImage/$fileName");
    firebaseStorageRef.putFile(_image!);
  }

  void updateData(String userkey) async {
    if (_image != null) {
      final updatedData = {
        "Duration": controllerPackageDuration.text,
        "Include": controllerPackageIncludes.text,
        "PackageName": controllerPackageName.text,
        "Price": controllerPackagePrice.text,
        "Photo": fileName,
      };
      uploadImage();
      if (imageName != "") {
        final desertRef =
            FirebaseStorage.instance.ref("PackageImage/$imageName");
        await desertRef.delete();
      }
      final userRef = FirebaseDatabase.instance
          .ref()
          .child("ArogyaSair/tblPackages")
          .child(userkey);
      await userRef.update(updatedData);
    } else {
      final updatedData = {
        "Duration": controllerPackageDuration.text,
        "Include": controllerPackageIncludes.text,
        "PackageName": controllerPackageName.text,
        "Price": controllerPackagePrice.text,
      };
      final userRef = FirebaseDatabase.instance
          .ref()
          .child("ArogyaSair/tblPackages")
          .child(userkey);
      await userRef.update(updatedData);
    }
  }

  Future<void> removePackages(String packageKey, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Alert"),
          content: Text(
              "Sure, you want to delete ${widget.packageData["PackageName"]} package ?"),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                await FirebaseDatabase.instance
                    .ref()
                    .child("ArogyaSair/tblPackages")
                    .child(packageKey)
                    .remove();
                if (imageName != "") {
                  final desertRef =
                      FirebaseStorage.instance.ref("PackageImage/$imageName");
                  await desertRef.delete();
                }
                backToHome();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void backToHome() {
    Navigator.pop(this.context);
    Navigator.pop(this.context);
    Navigator.pop(this.context);
  }
}
