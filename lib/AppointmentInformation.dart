// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class AppointmentInformation extends StatefulWidget {
  final String item;
  final String HospitalName;
  final String Date;
  final String Status;

  const AppointmentInformation(
      {super.key,
      required this.item,
      required this.HospitalName,
      required this.Date,
      required this.Status});

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
        backgroundColor: Colors.blue.shade900,
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
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Align content to the left
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Appointment For :",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.item,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.hospital),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.HospitalName,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0), // Add some vertical spacing
                    Row(
                      children: [
                        const Text(
                          "Starting Date :",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.Date,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Lottie.asset(
                          'assets/Animation/booking_confirmation.json'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
