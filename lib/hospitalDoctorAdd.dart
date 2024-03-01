// ignore_for_file: file_names

import 'package:arogyasair/hospitalNewDoctorAdd.dart';
import 'package:arogyasair/models/DoctorModel.dart';
import 'package:arogyasair/models/HospitalDoctorModel.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class HospitalDoctorAdd extends StatefulWidget {
  const HospitalDoctorAdd({Key? key}) : super(key: key);

  @override
  State<HospitalDoctorAdd> createState() => _HospitalDoctorAddState();
}

class _HospitalDoctorAddState extends State<HospitalDoctorAdd> {
  TimeOfDay? selectedTimeFrom;
  TimeOfDay? selectedTimeTo;
  DatabaseReference dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospitalDoctor');
  List<MultiSelectItem<DoctorData>> items = [];
  List<DoctorData> selectedItems2 = [];
  late String hospitalKey;
  String timeFrom = "From";
  String timeTo = "To";
  String status = "0";

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
                child: StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .ref()
                      .child("ArogyaSair/tblDoctor")
                      .onValue,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data!.snapshot.value != null) {
                      Map<dynamic, dynamic> facilitiesMap =
                          snapshot.data!.snapshot.value;
                      items.clear();
                      facilitiesMap.forEach((key, value) {
                        items.add(MultiSelectItem<DoctorData>(
                            DoctorData.fromMap(value, key),
                            value["DoctorName"]));
                      });
                      return Column(
                        children: <Widget>[
                          MultiSelectBottomSheetField(
                            initialChildSize: 0.4,
                            listType: MultiSelectListType.CHIP,
                            searchable: true,
                            buttonText: const Text("Select Doctors"),
                            title: const Text("Select Doctors"),
                            items: items,
                            onConfirm: (values) {
                              selectedItems2 = values.cast<DoctorData>();
                            },
                            chipDisplay: MultiSelectChipDisplay(
                              onTap: (value) {
                                setState(() {
                                  selectedItems2.remove(value);
                                });
                              },
                            ),
                          ),
                          selectedItems2.isEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "None selected",
                                    style: TextStyle(color: Colors.black54),
                                  ))
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
              var doctor = selectedItems2.map((item) => item.doctors).join(',');
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
