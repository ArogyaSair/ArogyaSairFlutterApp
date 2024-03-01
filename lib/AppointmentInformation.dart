// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class AppointmentInformation extends StatefulWidget {
  final String item;
  final String HospitalName;
  final String Date;
  final String Status;

  const AppointmentInformation(
      {Key? key,
      required this.item,
      required this.HospitalName,
      required this.Date,
      required this.Status})
      : super(key: key);

  @override
  State<AppointmentInformation> createState() => _AppointmentInformationState();
}

class _AppointmentInformationState extends State<AppointmentInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Appointment Details",
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(1),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Align content to the left
                children: [
                  Text(
                    widget.item,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0), // Add some vertical spacing
                  Text(
                    widget.HospitalName,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.Date,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
