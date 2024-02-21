import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PackageInformation extends StatefulWidget {
  final String key1;

  const PackageInformation({required this.key1});

  @override
  _packageInformation createState() => _packageInformation();
}

class _packageInformation extends State<PackageInformation> {
  Future<DataSnapshot> _fetchData(String key) async {
    print("Key is $key");
    final ref = FirebaseDatabase.instance.ref('ArogyaSair/tblHospital/$key');
    final snapshot = await ref.get();
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    final key = widget.key1;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hospital"),
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder<DataSnapshot>(
            future: _fetchData(key),
            builder: (BuildContext, snapshot) {
              Map data;
              if (snapshot.hasData) {
                data = snapshot.data!.value as Map;
                final hospitalName = data['HospitalName']?.toString();
                final AvailableDoctors = data['AvailableDoctors']?.toString();
                final AvailableFacilities =
                    data['AvailableFacilities']?.toString();
                final AvailableTreatments =
                    data['AvailableTreatments']?.toString();
                final hospitalCity = data['HospitalCity']?.toString();
                final hospitalState = data['HospitalState']?.toString();
                final hospitalAddress = data['HospitalAddress']?.toString();
                final Email = data['Email']?.toString();
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    Text(hospitalName!),
                    Text(AvailableDoctors!),
                    Text(AvailableFacilities!),
                    Text(AvailableTreatments!),
                    Text(hospitalCity!),
                    Text(hospitalState!),
                    Text(hospitalAddress!),
                    Text(Email!),
                  ],
                ));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
