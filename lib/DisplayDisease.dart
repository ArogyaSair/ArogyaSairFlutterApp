// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'HospitalSelection.dart';
import 'models/SurgeryData.dart';

class DisplaySurgery extends StatefulWidget {
  const DisplaySurgery({super.key});

  @override
  State<DisplaySurgery> createState() => _DisplayDiseaseState();
}

class _DisplayDiseaseState extends State<DisplaySurgery> {
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Surgeries",
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search Surgery',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width: 5.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchTerm = value.toLowerCase();
                  });
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .ref()
                      .child("ArogyaSair/AllSurgeries")
                      .onValue,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data!.snapshot.value != null) {
                      Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
                      List<SurgeryModel> surgeryList = [];
                      surgeryList.clear();
                      map.forEach((key, value) {
                        surgeryList.add(SurgeryModel.fromMap(value, key));
                      });
                      // Filter the diseaseList based on the search term
                      List<SurgeryModel> filteredList = surgeryList
                          .where((surgery) => surgery.surgery
                              .toLowerCase()
                              .contains(_searchTerm))
                          .toList();
                      if (filteredList.isEmpty) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/Animation/searching_disease.json',
                                  // Path to your Lottie animation file
                                  width: 350, // Increase the width
                                  height: 240, // Increase the height
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Not Found',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  filteredList[index].surgery,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PackageHospitalSelection(
                                    diseaseList: filteredList[index],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
