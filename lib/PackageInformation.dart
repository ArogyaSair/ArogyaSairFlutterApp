// ignore_for_file: file_names, library_private_types_in_public_api, camel_case_types

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PackageInformation extends StatefulWidget {
  final String key1;

  const PackageInformation({Key? key, required this.key1}) : super(key: key);

  @override
  _packageInformation createState() => _packageInformation();
}

class _packageInformation extends State<PackageInformation> {

  @override
  Widget build(BuildContext context) {
    final key = widget.key1;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospital"),
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
        children: [
          SizedBox(
            child: StreamBuilder<dynamic>(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child("ArogyaSair/tblHospital/$key")
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  final data =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

                  // Handle null check and property existence:
                  if (data.containsKey('AvailableDoctors')) {
                    final availableDoctorsString =
                        data['AvailableDoctors'].toString();

                    // Split into a list with proper handling:
                    final availableDoctorsList =
                        availableDoctorsString.isNotEmpty
                            ? availableDoctorsString.split(', ')
                            : [];

                    return Card(
                      child: Column(
                        children: [
                          // Display hospital name using appropriate widget (e.g., Text, ListTile)
                          ListTile(
                            title:
                                Text(data['HospitalName'] ?? 'Hospital Name'),
                          ),
                          if (availableDoctorsList.isNotEmpty) ...[
                            // Separate widget for doctor name display (e.g., ListView.builder)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: availableDoctorsList.length,
                              itemBuilder: (context, index) {
                                final doctorName = availableDoctorsList[index];
                                return Text(doctorName);
                              },
                            ),
                          ] else ...[
                            // Handle the case when no doctors are available
                            const Text('No doctors available'),
                          ],
                        ],
                      ),
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