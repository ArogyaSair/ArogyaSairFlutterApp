// ignore_for_file: file_names

import 'package:arogyasair/hospitalNewDoctorAdd.dart';
import 'package:arogyasair/models/HospitalDoctorModel.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(
    home: HospitalDoctorAdd1(),
  ));
}

class HospitalDoctorAdd1 extends StatefulWidget {
  const HospitalDoctorAdd1({super.key});

  @override
  State<HospitalDoctorAdd1> createState() => _HospitalDoctorAddState1();
}

class _HospitalDoctorAddState1 extends State<HospitalDoctorAdd1> {
  TimeOfDay? selectedTimeFrom;
  TimeOfDay? selectedTimeTo;
  DatabaseReference dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospitalDoctor');
  List<String> items = [];
  late String selectedDoctors;
  late String hospitalKey;
  String timeFrom = "From";
  String timeTo = "To";
  String status = "Available";

  // string hos

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? userKey = await getKey();
    setState(() {
      hospitalKey = userKey!;
    });
  }

  Future<void> getHospitalData() async {
    items = ['Select Doctor'];
    selectedDoctors = 'Select Doctor';
    hospitalKey = hospitalKey;
    Query dbRef =
        FirebaseDatabase.instance.ref().child("ArogyaSair/tblHospitalDoctor");
    dbRef
        .orderByChild("Hospital_ID")
        .equalTo(hospitalKey)
        .onValue
        .listen((event) {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        values.forEach((key, value) {
          items.add(value['Doctor']);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Doctor"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 150,
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: FutureBuilder<void>(
                  future: getHospitalData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 700,
                            width: double.infinity,
                            child: ListView(
                              children: [
                                Card(
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(12),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 44,
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: DropdownButton(
                                            alignment: Alignment.centerRight,
                                            value: selectedDoctors,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            style: const TextStyle(
                                                color: Colors.black),
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            items: items.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedDoctors = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text("Select doctor's time:-"),
                Padding(
                  padding: const EdgeInsets.all(10), // main code
                  child: ElevatedButton(
                    child: Text(timeFrom),
                    onPressed: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: selectedTimeFrom ?? TimeOfDay.now(),
                        initialEntryMode: TimePickerEntryMode.dial,
                        orientation: Orientation.portrait,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                            ),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  alwaysUse24HourFormat: false,
                                ),
                                child: child!,
                              ),
                            ),
                          );
                        },
                      );
                      setState(() {
                        selectedTimeFrom = time;
                        timeFrom = selectedTimeFrom!.format(context);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1), // main code
                  child: ElevatedButton(
                    child: Text(timeTo),
                    onPressed: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: selectedTimeTo ?? TimeOfDay.now(),
                        initialEntryMode: TimePickerEntryMode.dial,
                        orientation: Orientation.portrait,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                            ),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  alwaysUse24HourFormat: false,
                                ),
                                child: child!,
                              ),
                            ),
                          );
                        },
                      );
                      setState(() {
                        selectedTimeTo = time;
                        timeTo = selectedTimeTo!.format(context);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              var doctor = selectedDoctors;
              HospitalDoctor regobj =
                  HospitalDoctor(doctor, hospitalKey, status, timeFrom, timeTo);
              dbRef2.push().set(regobj.toJson());
              Navigator.of(context).pop();
            },
            child: const Text("Add Doctor"),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        child: Tooltip(
          message: "This is button",
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HospitalNewDoctorAdd()));
            },
            icon: const Icon(Icons.add),
            label: const Text("New Doctor"),
          ),
        ),
      ),
    );
  }
}
