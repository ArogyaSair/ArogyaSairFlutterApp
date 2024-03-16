// ignore_for_file: file_names

import 'package:arogyasair/hospitalNewDoctorAdd.dart';
import 'package:arogyasair/models/DiseaseModel.dart';
import 'package:arogyasair/models/HospitalDoctorModel.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class HospitalDoctorAdd extends StatefulWidget {
  const HospitalDoctorAdd({super.key});

  @override
  State<HospitalDoctorAdd> createState() => _HospitalDoctorAddState();
}

class _HospitalDoctorAddState extends State<HospitalDoctorAdd> {
  TimeOfDay? selectedTimeFrom;
  TextEditingController controllerDoctor = TextEditingController();
  TimeOfDay? selectedTimeTo;
  DatabaseReference dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospitalDoctor');
  List<String> items = [];
  late String selectedDoctors = 'Select Doctor';
  late String hospitalKey;
  String timeFrom = "From";
  String timeTo = "To";
  String status = "Available";
  List<MultiSelectItem<String>> diseaseItems = [];
  List<DiseaseData> selectedItems = [];

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
    hospitalKey = hospitalKey;
    Query dbRef = FirebaseDatabase.instance.ref().child("ArogyaSair/tblDoctor");
    dbRef.onValue.listen((event) {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        values.forEach((key, value) {
          items.add(value['DoctorName']);
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
            child: FutureBuilder<void>(
              future: getHospitalData(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: ListView(
                          children: [
                            Card(
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        icon: const Icon(Icons.arrow_drop_down),
                                        items: items.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedDoctors = newValue!;
                                            if (selectedDoctors !=
                                                "Select Doctor") {
                                              controllerDoctor.text =
                                                  selectedDoctors;
                                            }
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
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: controllerDoctor,
              enabled: false,
              style: const TextStyle(color: Colors.black),
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
          StreamBuilder(
            stream: FirebaseDatabase.instance
                .ref()
                .child("ArogyaSair/tblDisease")
                .onValue,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                Map<dynamic, dynamic> facilitiesMap =
                    snapshot.data!.snapshot.value;
                List<MultiSelectItem<DiseaseData>> diseaseItems = [];
                diseaseItems.clear();
                facilitiesMap.forEach(
                  (key, value) {
                    diseaseItems.add(
                      MultiSelectItem<DiseaseData>(
                        DiseaseData.fromMap(value, key),
                        value["DiseaseName"],
                      ),
                    );
                  },
                );
                return Column(
                  children: <Widget>[
                    MultiSelectBottomSheetField(
                      initialChildSize: 0.4,
                      listType: MultiSelectListType.CHIP,
                      searchable: true,
                      buttonText: const Text("Select Disease"),
                      title: const Text("Select Disease"),
                      items: diseaseItems,
                      onConfirm: (values) {
                        selectedItems = values.cast<DiseaseData>();
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (value) {
                          setState(
                            () {
                              selectedItems.remove(value);
                            },
                          );
                        },
                      ),
                    ),
                    selectedItems.isEmpty
                        ? Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "None selected",
                              style: TextStyle(color: Colors.black54),
                            ),
                          )
                        : Container(),
                  ],
                );
              } else {
                return const CircularProgressIndicator(
                  backgroundColor: Colors.redAccent,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                  strokeWidth: 1.5,
                );
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              var doctor = controllerDoctor.text;
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
