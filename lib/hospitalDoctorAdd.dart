// ignore_for_file: file_names

import 'package:arogyasair/hospitalNewDoctorAdd.dart';
import 'package:arogyasair/models/HospitalDoctorModel.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HospitalDoctorAdd extends StatefulWidget {
  const HospitalDoctorAdd({super.key});

  @override
  State<HospitalDoctorAdd> createState() => _HospitalDoctorAddState();
}

class _HospitalDoctorAddState extends State<HospitalDoctorAdd> {
  TimeOfDay? selectedTimeFrom;
  TimeOfDay? selectedTimeTo;
  DatabaseReference dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospitalDoctor');
  List<String> itemsSpecialization = [];
  List<String> itemsDoctor = [];
  late String selectedDoctors = 'Select Specialization';
  late String hospitalKey;
  String timeFrom = "From";
  String timeTo = "To";
  String status = "Available";
  var imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/DoctorImage%2FDefaultProfileImage.png?alt=media";
  Map<dynamic, dynamic>? userData;
  Map<dynamic, dynamic>? hospitalDoctorData;
  List<Map<dynamic, dynamic>> userMap = []; // Change this line
  // List<Map<dynamic, dynamic>> hospitalDoctorMap = []; // Change this line
  List hospitalDoctorMap = []; // Change this line

  @override
  void initState() {
    super.initState();
    _loadUserData();
    getSpecializationData();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    userMap.clear();
    imagePath =
        "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/DoctorImage%2FDefaultProfileImage.png?alt=media";
    DatabaseReference dbUserData =
        FirebaseDatabase.instance.ref().child("ArogyaSair/tblDoctor");
    DatabaseEvent userDataEvent = await dbUserData.once();
    DataSnapshot userDataSnapshot = userDataEvent.snapshot;
    userData = userDataSnapshot.value as Map?;

    DatabaseReference dbHospitalDoctorData =
        FirebaseDatabase.instance.ref().child("ArogyaSair/tblHospitalDoctor");
    DatabaseEvent hospitalDoctorDataEvent = await dbHospitalDoctorData.once();
    DataSnapshot hospitalDoctorDataSnapshot = hospitalDoctorDataEvent.snapshot;
    hospitalDoctorData = hospitalDoctorDataSnapshot.value as Map?;
    hospitalDoctorData?.forEach((key, value) {
      if (value["Hospital_ID"] == hospitalKey) {
        hospitalDoctorMap.add(value["Doctor"]);
      }
    });

    userData!.forEach((key, value) {
      if (!hospitalDoctorMap.contains(key)) {
        userMap.add({
          "Key": key,
          "DoctorName": value!["DoctorName"],
          "Speciality": value["Speciality"],
          "Photo": value["Photo"],
        });
      }
    });
    setState(() {});
  }

  Future<void> _loadUserData() async {
    String? userKey = await getKey();
    setState(() {
      hospitalKey = userKey!;
    });
  }

  Future<void> getSpecializationData() async {
    itemsSpecialization.clear();
    itemsSpecialization = ['Select Specialization'];
    hospitalKey = hospitalKey;
    Query dbRef = FirebaseDatabase.instance.ref().child("ArogyaSair/tblSpe");
    dbRef.onValue.listen((event) {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        Set<String> uniqueSpecializations = {};
        values.forEach((key, value) {
          uniqueSpecializations.add(value['Specilization']);
        });
        itemsSpecialization.addAll(uniqueSpecializations
            .toList()); // Convert set back to list and add to itemsSpecialization
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Doctor"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder<void>(
                future: getSpecializationData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      itemsSpecialization.isEmpty &&
                      userMap.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.3,
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          style: const TextStyle(
                                              color: Colors.black),
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          items: itemsSpecialization
                                              .map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            if (selectedDoctors !=
                                                "Select Specialization") {
                                              fetchUserData();
                                            }
                                            setState(() {
                                              fetchUserData();
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
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: userMap
                              .where((user) =>
                                  selectedDoctors == user['Speciality'])
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            // image code
                            final filteredUsers = userMap
                                .where((user) =>
                                    selectedDoctors == user['Speciality'])
                                .toList();
                            final user = filteredUsers[index];
                            if (user["Photo"] != "") {
                              imagePath =
                                  "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/DoctorImage%2F${user["Photo"]}?alt=media";
                            }
                            return Card(
                              child: ListTile(
                                title: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    imagePath,
                                    height:
                                        MediaQuery.of(context).size.width * 0.2,
                                    width: MediaQuery.of(context).size.width *
                                        0.22,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['DoctorName'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(user['Speciality']),
                                  ],
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Select doctor's time:-"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                if (selectedTimeFrom != null)
                                                  Text(
                                                      'Selected Time From: ${selectedTimeFrom!.hour}:${selectedTimeFrom!.minute}'),
                                                if (selectedTimeTo != null)
                                                  Text(
                                                      'Selected Time To: ${selectedTimeTo!.hour}:${selectedTimeTo!.minute}'),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('From'),
                                                onPressed: () async {
                                                  TimeOfDay? timeFrom =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        selectedTimeFrom ??
                                                            TimeOfDay.now(),
                                                    initialEntryMode:
                                                        TimePickerEntryMode
                                                            .dial,
                                                    orientation:
                                                        Orientation.portrait,
                                                    useRootNavigator: false,
                                                    builder:
                                                        (BuildContext context,
                                                            Widget? child) {
                                                      return MediaQuery(
                                                        data: MediaQuery.of(
                                                                context)
                                                            .copyWith(
                                                                alwaysUse24HourFormat:
                                                                    false),
                                                        child: child!,
                                                      );
                                                    },
                                                  );
                                                  setState(() {
                                                    selectedTimeFrom = timeFrom;
                                                    if (timeFrom != null) {
                                                      timeFrom =
                                                          '${timeFrom?.hourOfPeriod}:${timeFrom?.minute} ${timeFrom?.period.index == 0 ? 'AM' : 'PM'}'
                                                              as TimeOfDay?; // Update timeFrom
                                                    }
                                                  });
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('To'),
                                                onPressed: () async {
                                                  final TimeOfDay? time =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        selectedTimeTo ??
                                                            TimeOfDay.now(),
                                                    initialEntryMode:
                                                        TimePickerEntryMode
                                                            .dial,
                                                    orientation:
                                                        Orientation.portrait,
                                                    useRootNavigator: false,
                                                    builder:
                                                        (BuildContext context,
                                                            Widget? child) {
                                                      return MediaQuery(
                                                        data: MediaQuery.of(
                                                                context)
                                                            .copyWith(
                                                                alwaysUse24HourFormat:
                                                                    false),
                                                        child: child!,
                                                      );
                                                    },
                                                  );
                                                  setState(() {
                                                    selectedTimeTo = time;
                                                    if (time != null) {
                                                      timeTo =
                                                          '${time.hourOfPeriod}:${time.minute} ${time.period.index == 0 ? 'AM' : 'PM'}'; // Format time with AM/PM suffix
                                                    }
                                                  });
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Ok'),
                                                onPressed: () {
                                                  {
                                                    var doctor =
                                                        user['DoctorName'];
                                                    HospitalDoctor regobj =
                                                        HospitalDoctor(
                                                            doctor,
                                                            hospitalKey,
                                                            status,
                                                            timeFrom,
                                                            timeTo);
                                                    dbRef2
                                                        .push()
                                                        .set(regobj.toJson());
                                                    Navigator.of(context).pop();
                                                  }
                                                  Navigator.pop(
                                                      context); // Close the AlertDialog
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        child: Tooltip(
          message: "This is button",
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HospitalNewDoctorAdd(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("New Doctor"),
          ),
        ),
      ),
    );
  }
}
