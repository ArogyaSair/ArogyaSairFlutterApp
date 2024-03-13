// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';

class contact extends StatelessWidget {
  final String PackageName;
  final String Price;
  final String HospitalName;
  final String Duration;
  final String Incude;
  final String Image;

  const contact({super.key,
      required this.PackageName,
      required this.Price,
      required this.HospitalName,
      required this.Duration,
      required this.Incude,
      required this.Image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(PackageName),
          Text(Price),
          Text(HospitalName),
          Text(Duration),
          Text(Incude),
          Text(Image),
        ],
      ),
    );
  }
}
