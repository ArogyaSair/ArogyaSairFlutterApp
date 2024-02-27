// ignore_for_file: file_names, library_private_types_in_public_api, camel_case_types

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'HospitalPackageEdit.dart';

class PackageInformation extends StatefulWidget {
  final String key1;
  final String HospitalName;

  const PackageInformation(this.HospitalName, this.key1, {Key? key})
      : super(key: key);

  @override
  _packageInformation createState() => _packageInformation();
}

class _packageInformation extends State<PackageInformation> {
  @override
  Widget build(BuildContext context) {
    final key = widget.key1;

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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HospitalPackageEdit(widget.HospitalName)));
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
                  final data =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

                  // Handle null check and property existence:
                  if (data.containsKey('Include')) {
                    final PackageString = data['Include'].toString();

                    // Split into a list with proper handling:
                    final PackgeList = PackageString.isNotEmpty
                        ? PackageString.split(', ')
                        : [];

                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                              "Hospital Name : ${widget.HospitalName}" ??
                                  'Hospital Name'),
                        ),
                        if (PackgeList.isNotEmpty) ...[
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: PackgeList.length,
                            itemBuilder: (context, index) {
                              final doctorName = PackgeList[index];
                              return Text(
                                  "What includes in this packages : $doctorName");
                            },
                          ),
                        ] else ...[
                          // Handle the case when no doctors are available
                          const Text('No doctors available'),
                        ],
                      ],
                    );
                  } else {
                    return const Text(
                        'Hospital data is missing or incomplete.');
                  }
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
