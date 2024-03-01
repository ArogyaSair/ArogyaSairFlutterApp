// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously

import 'package:arogyasair/hospital_register_image_add.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'models/FacilitiesModel.dart';
import 'models/TreatmentModel.dart';

class HospitalServices extends StatefulWidget {
  const HospitalServices({Key? key}) : super(key: key);

  @override
  _HospitalServicesState createState() => _HospitalServicesState();
}

class _HospitalServicesState extends State<HospitalServices> {
  List<MultiSelectItem<String>> items = [];
  List<TreatmentModel> selectedItems = [];
  List<FacilityData> selectedItems2 = [];
  String? Key;
  var logger = Logger();

  Future<void> loadData() async {
    var key1 = await getKey();
    Key = key1;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Center(
                  child: Image.asset(
                    'assets/Logo/ArogyaSair.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 150,
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: StreamBuilder(
                      stream: FirebaseDatabase.instance
                          .ref()
                          .child("ArogyaSair/AllTreatment")
                          .onValue,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data!.snapshot.value != null) {
                          Map<dynamic, dynamic> facilitiesMap =
                              snapshot.data!.snapshot.value;
                          List<MultiSelectItem<TreatmentModel>> items = [];
                          items.clear();
                          facilitiesMap.forEach((key, value) {
                            items.add(MultiSelectItem<TreatmentModel>(
                                TreatmentModel.fromMap(value, key),
                                value["TreatmentName"]));
                          });
                          return Column(
                            children: <Widget>[
                              MultiSelectBottomSheetField(
                                initialChildSize: 0.4,
                                listType: MultiSelectListType.CHIP,
                                searchable: true,
                                buttonText: const Text("Select Treatments"),
                                title: const Text("Select Treatments"),
                                items: items,
                                onConfirm: (values) {
                                  selectedItems = values.cast<TreatmentModel>();
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      selectedItems.remove(value);
                                    });
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 150,
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: StreamBuilder(
                      stream: FirebaseDatabase.instance
                          .ref()
                          .child("ArogyaSair/AllServices")
                          .onValue,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data!.snapshot.value != null) {
                          Map<dynamic, dynamic> facilitiesMap =
                              snapshot.data!.snapshot.value;
                          List<MultiSelectItem<FacilityData>> items2 = [];
                          items2.clear();
                          facilitiesMap.forEach((key, value) {
                            items2.add(MultiSelectItem<FacilityData>(
                                FacilityData.fromMap(value, key),
                                value["ServiceName"]));
                          });
                          return Column(
                            children: <Widget>[
                              MultiSelectBottomSheetField(
                                initialChildSize: 0.4,
                                listType: MultiSelectListType.CHIP,
                                searchable: true,
                                buttonText: const Text("Select Services"),
                                title: const Text("Select Services"),
                                items: items2,
                                onConfirm: (values2) {
                                  selectedItems2 = values2.cast<FacilityData>();
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value2) {
                                    setState(() {
                                      selectedItems2.remove(value2);
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed: () async {
                    final updateData = {
                      "AvailableFacilities": selectedItems2
                          .map((item) => item.facilities)
                          .join(','),
                      "AvailableTreatments":
                          selectedItems.map((item) => item.treatment).join(','),
                    };
                    final hospitalRef = FirebaseDatabase.instance
                        .ref()
                        .child("ArogyaSair/tblHospital")
                        .child(Key!);
                    await hospitalRef.update(updateData);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const HospitalRegisterImageAdd()));
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
