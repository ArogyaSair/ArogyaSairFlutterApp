import 'dart:io';

import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class HospitalPackageEdit extends StatefulWidget {
  late String hospitalName;

  HospitalPackageEdit(this.hospitalName, {Key? key}) : super(key: key);

  @override
  State<HospitalPackageEdit> createState() => _HospitalPackageEditState();
}

class _HospitalPackageEditState extends State<HospitalPackageEdit> {
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  var imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/UserImage%2FDefaultProfileImage.png?alt=media";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Query Ref;
  late Map data;
  late TextEditingController controllerpackagename;
  late TextEditingController controllerpackageprice;
  late TextEditingController controllerpackageincludes;
  late TextEditingController controllerhospitalname;
  late TextEditingController controllerpackageduration;
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
        title: const Text(
          "Packages",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
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
              onPressed: () {},
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
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Center(
                        child: Image.asset(
                          'assets/Logo/ArogyaSair.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                                backgroundColor: Colors.blue),
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
                      controller: controllerpackagename,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Package name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
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
                      controller: controllerpackageprice,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter price';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.person),
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
                      controller: controllerpackageincludes,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter tests and reports Package include';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.person),
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
                      controller: controllerhospitalname,
                      enabled: false,
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.person),
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
                      controller: controllerpackageduration,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Duration(in Weeks)';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Duration In Weeks',
                        hintText: 'Enter Durationn in Weeks',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var name = controllerpackagename.text;
                          var price = controllerpackageprice.text;
                          var hospitalname = controllerhospitalname.text;
                          var duartion = controllerpackageduration.text;
                          var includes = controllerpackageincludes.text;
                        }
                      },
                      child: const Text("Update"),
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
    // String? userData = await getData(key);
    // String? userEmail = await getData(key1);
    String? userkey = await getData("Key");

    // username = userData!;
    // email = userEmail!;
    userKey = userkey!;
    logger.d("key is $userKey");
    Ref = FirebaseDatabase.instance
        .ref()
        .child("ArogyaSair/tblPackages/$userkey");

    await Ref.once().then((documentSnapshot) async {
      for (var x in documentSnapshot.snapshot.children) {
        data = x.value as Map;
        controllerpackagename =
            TextEditingController(text: data["PackageName"]);
        controllerpackageprice = TextEditingController(text: data["Price"]);
        controllerpackageincludes =
            TextEditingController(text: data["Include"]);
        controllerhospitalname =
            TextEditingController(text: widget.hospitalName);
        controllerpackageduration =
            TextEditingController(text: data["Duration"]);
        if (data["Photo"] != null) {
          imagePath =
              "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/UserImage%2F${data["Photo"]}?alt=media";
          imageName = data["Photo"];
        }
      }
    });
  }
}
