// ignore_for_file: file_names, library_private_types_in_public_api, camel_case_types, non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'HospitalPackageEdit.dart';

class PackageInformation extends StatefulWidget {
  final String key1;
  final String HospitalName;

  const PackageInformation(this.HospitalName, this.key1, {super.key});

  @override
  _packageInformation createState() => _packageInformation();
}

class _packageInformation extends State<PackageInformation> {
  @override
  Widget build(BuildContext context) {
    final key = widget.key1;
    late Map data;
    var imagePath =
        "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/PackageImage%2FDefaultProfileImage.png?alt=media";

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HospitalPackageEdit(
                        widget.HospitalName, widget.key1, data),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            child: StreamBuilder<dynamic>(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child("ArogyaSair/tblPackages/$key")
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  if (data["Photo"] != null) {
                    imagePath =
                        "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/PackageImage%2F${data["Photo"]}?alt=media";
                  }
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      imagePath,
                                      height: 100,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  widget.HospitalName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("Package name : ${data["PackageName"]}",
                                    style: const TextStyle(fontSize: 16.5)),
                                Text(
                                    "This package includes : ${data["Include"]}",
                                    style: const TextStyle(fontSize: 16.5)),
                                Text("Price is : ${data["Price"]}",
                                    style: const TextStyle(fontSize: 16.5)),
                                Text("Duration : ${data["Duration"]} weeks",
                                    style: const TextStyle(fontSize: 16.5)),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
