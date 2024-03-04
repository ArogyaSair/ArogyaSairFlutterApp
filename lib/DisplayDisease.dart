// import 'package:arogyasair/temp.dart';
// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'HospitalSelection.dart';

class DisplayDisease extends StatefulWidget {
  const DisplayDisease({Key? key}) : super(key: key);

  @override
  State<DisplayDisease> createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<DisplayDisease> {
  final List<String> items = [
    'Atrial fibrillation ',
    'Cardiomyopathy',
    'Peripheral vascular disease'
  ]; // Your data source

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Disease",
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
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HospitalPackagesTab(
                      item: items[index],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
