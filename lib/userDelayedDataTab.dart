// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:arogyasair/Notifications/hospital_appointment_delay_confirm_notification.dart';
import 'package:arogyasair/Notifications/hospital_appointment_delay_delay_notification.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'models/AppointmentDateSelectionModel.dart';
import 'models/HospitalTreatmentModel.dart';

class UserDelayedData extends StatefulWidget {
  final String userKey;
  final String userName;

  const UserDelayedData(this.userKey, this.userName, {super.key});

  @override
  _UserDelayedDataState createState() => _UserDelayedDataState();
}

class _UserDelayedDataState extends State<UserDelayedData> {
  late String imagePath;
  late String date;
  late String username;
  late String userkey;
  List<Map> Appointments = [];
  late String packageImagePath;
  Map<dynamic, dynamic>? userData;
  Map<int, Map> userMap = {};
  late Map data2;
  late var disease;
  bool dataFetched = false; // Flag to track if data has been fetched

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    String? Username = await getData("username");
    String? UserKey = await getKey();
    setState(() {
      username = Username!;
      userkey = UserKey!;
    });
    getPackagesData();
  }

  Future<void> fetchUserData(String key, int index) async {
    userMap.clear();
    DatabaseReference dbUserData = FirebaseDatabase.instance
        .ref()
        .child("ArogyaSair/tblHospital")
        .child(key);
    DatabaseEvent userDataEvent = await dbUserData.once();
    DataSnapshot userDataSnapshot = userDataEvent.snapshot;
    userData = userDataSnapshot.value as Map?;
    userMap[index] = {
      "Key": userDataSnapshot.key,
      "HospitalName": userData!["HospitalName"],
    };
    setState(() {});
  }

  Future<List<Map>> getPackagesData() async {
    // Appointments.clear();
    if (dataFetched) {
      return Appointments; // Return if data has already been fetched
    }
    DatabaseReference dbRef = FirebaseDatabase.instance
        .ref()
        .child('ArogyaSair/tblDelayedAppointment');
    DatabaseEvent event = await dbRef.once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value == null) {
      return Appointments;
    }

    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    Appointments.clear();
    values.forEach((key, value) async {
      if (value["Status"] == "Delayed" && value["UserId"] == userkey) {
        Appointments.add({
          'Key': key,
          'AppointmentId': value["AppointmentId"],
          'DoctorName': value["DoctorName"],
          'HospitalName': value['HospitalId'],
          'NewDate': value["NewDate"],
          'OldDate': value["OldDate"],
          'Status': value["Status"],
          'UserId': value["UserId"],
          'VisitingTime': value["VisitingTime"],
        });
        await fetchUserData(value["HospitalId"], Appointments.length - 1);
        dataFetched = true;
      }
    });
    setState(() {});
    return Appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: FutureBuilder<List<Map>>(
        future: getPackagesData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            if (Appointments.isNotEmpty && userMap.isNotEmpty) {
              return ListView.builder(
                itemCount: Appointments.length,
                itemBuilder: (context, index) {
                  data2 = userMap[index]!;
                  return Card(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    const FaIcon(FontAwesomeIcons.hospital),
                                    const SizedBox(width: 20),
                                    Text(
                                      "${data2['HospitalName']}",
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Old Date : ${Appointments[index]["OldDate"]}",
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "New Date : ${Appointments[index]["NewDate"]}",
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Time for visit : ${Appointments[index]["VisitingTime"]}",
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                      ),
                                      onPressed: () async {
                                        var datePicked = await DatePicker
                                            .showSimpleDatePicker(
                                          context,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now()
                                              .add(const Duration(days: 14)),
                                          dateFormat: "dd-MM-yyyy",
                                          locale: DateTimePickerLocale.en_us,
                                          looping: false,
                                        );
                                        setState(() {
                                          if (datePicked != null) {
                                            date =
                                                "${datePicked.day}-${datePicked.month}-${datePicked.year}";
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Alert Message"),
                                                  content:
                                                      Text("New will be $date"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('OK'),
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        DatabaseReference
                                                            dbAppointmentRef =
                                                            FirebaseDatabase
                                                                .instance
                                                                .ref()
                                                                .child(
                                                                    "ArogyaSair/tblAppointment/${Appointments[index]["AppointmentId"]}");
                                                        DatabaseEvent
                                                            databaseAppointmentEvent =
                                                            await dbAppointmentRef
                                                                .once();
                                                        DataSnapshot
                                                            dataAppointmentSnapshot =
                                                            databaseAppointmentEvent
                                                                .snapshot;
                                                        Map dataAppointment =
                                                            dataAppointmentSnapshot
                                                                .value as Map;
                                                        var hospitalkey =
                                                            Appointments[index][
                                                                "HospitalName"];
                                                        disease =
                                                            dataAppointment[
                                                                "Disease"];
                                                        var Date = date;
                                                        var user =
                                                            Appointments[index]
                                                                ["UserId"];
                                                        var status = "Pending";
                                                        AppointmentDateSelectionModel
                                                            regobj =
                                                            AppointmentDateSelectionModel(
                                                                hospitalkey,
                                                                disease,
                                                                Date,
                                                                user,
                                                                status);

                                                        DatabaseReference
                                                            dbRef2 =
                                                            FirebaseDatabase
                                                                .instance
                                                                .ref()
                                                                .child(
                                                                    'ArogyaSair/tblAppointment');
                                                        dbRef2.push().set(
                                                            regobj.toJson());
                                                        var delayedAppointmentId =
                                                            Appointments[index]
                                                                ["Key"];
                                                        DatabaseReference
                                                            dbDelayedAppointmentRef =
                                                            FirebaseDatabase
                                                                .instance
                                                                .ref()
                                                                .child(
                                                                    "ArogyaSair/tblDelayedAppointment/$delayedAppointmentId");
                                                        final updatedDelayedAppointmentData =
                                                            {
                                                          "Status": "Delay",
                                                        };
                                                        sendAppointmentDelayToHospital(
                                                            hospitalKey:
                                                                hospitalkey,
                                                            appointmentDate:
                                                                Appointments[
                                                                        index]
                                                                    ["NewDate"],
                                                            disease: disease,
                                                            status: "Delay",
                                                            userName: username,
                                                            newDate: date);
                                                        dbDelayedAppointmentRef
                                                            .update(
                                                                updatedDelayedAppointmentData);
                                                        dataFetched = false;
                                                        getPackagesData();
                                                        setState(() {});
                                                      },
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child:
                                                          const Text("Cancel"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        });
                                      },
                                      child: const Text(
                                        "Delay",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: TextButton(
                                      onPressed: () async {
                                        DatabaseReference dbAppointmentRef =
                                            FirebaseDatabase.instance.ref().child(
                                                "ArogyaSair/tblAppointment/${Appointments[index]["AppointmentId"]}");
                                        DatabaseEvent databaseAppointmentEvent =
                                            await dbAppointmentRef.once();
                                        var delayedAppointmentId =
                                            Appointments[index]["Key"];

                                        DataSnapshot dataAppointmentSnapshot =
                                            databaseAppointmentEvent.snapshot;
                                        Map dataAppointment =
                                            dataAppointmentSnapshot.value
                                                as Map;

                                        DatabaseReference
                                            dbDelayedAppointmentRef =
                                            FirebaseDatabase.instance.ref().child(
                                                "ArogyaSair/tblDelayedAppointment/$delayedAppointmentId");
                                        DatabaseEvent
                                            databaseDelayedAppointmentEvent =
                                            await dbDelayedAppointmentRef
                                                .once();
                                        DataSnapshot
                                            dataDelayedAppointmentSnapshot =
                                            databaseDelayedAppointmentEvent
                                                .snapshot;
                                        Map dataDelayedAppointment =
                                            dataDelayedAppointmentSnapshot.value
                                                as Map;
                                        DatabaseReference tblTreatment =
                                            FirebaseDatabase.instance
                                                .ref()
                                                .child(
                                                    "ArogyaSair/tblTreatment");
                                        HospitalTreatmentModel
                                            treatmentModelObject =
                                            HospitalTreatmentModel(
                                          dataDelayedAppointment["DoctorName"],
                                          widget.userKey,
                                          dataAppointment["Disease"],
                                          dataAppointment["HospitalId"],
                                          Appointments[index]["AppointmentId"],
                                          dataDelayedAppointment["NewDate"],
                                          "Approved",
                                          Appointments[index]["VisitingTime"],
                                        );
                                        tblTreatment
                                            .push()
                                            .set(treatmentModelObject.toJson());
                                        final updatedAppointmentData = {
                                          "Status": "Approved",
                                        };
                                        dbAppointmentRef
                                            .update(updatedAppointmentData);
                                        final updatedDelayedAppointmentData = {
                                          "Status": "Approved",
                                        };
                                        dbDelayedAppointmentRef.update(
                                            updatedDelayedAppointmentData);
                                        sendAppointmentDelayConfirmationToHospital(
                                            hospitalKey:
                                                dataAppointment["HospitalId"],
                                            disease: dataAppointment["Disease"],
                                            username: username,
                                            hospitalName: data2['HospitalName'],
                                            newDate: dataDelayedAppointment[
                                                "NewDate"]);
                                        dataFetched = false;
                                        getPackagesData();
                                        setState(() {});
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                      ),
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                " D ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No delayed appointments found'));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      //
    );
  }
}
