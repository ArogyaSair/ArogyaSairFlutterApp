// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';

import 'models/AppointmentDateSelectionModel.dart';
import 'models/HospitalTreatmentModel.dart';
import 'models/user_delayed_appointment_show.dart';

class UserDelayedData extends StatefulWidget {
  final String userKey;
  final String userName;

  const UserDelayedData(this.userKey, this.userName, {Key? key})
      : super(key: key);

  @override
  _UserDelayedDataState createState() => _UserDelayedDataState();
}

class _UserDelayedDataState extends State<UserDelayedData> {
  late String imagePath;
  late String date;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: StreamBuilder(
          stream: FirebaseDatabase.instance
              .ref()
              .child("ArogyaSair/tblDelayedAppointment")
              .onValue,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
              List<UserDelayedAppointmentShow> hospitalList = [];
              hospitalList.clear();
              map.forEach((key, value) {
                if (value["UserId"] == widget.userKey) {
                  if (value["Status"] == "Delayed") {
                    hospitalList
                        .add(UserDelayedAppointmentShow.fromMap(value, key));
                  }
                }
              });
              if (hospitalList.isNotEmpty) {
                return ListView.builder(
                  itemCount: hospitalList.length,
                  padding: const EdgeInsets.all(2),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Old Date is for : ${hospitalList[index].oldDate}",
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Hospital Name : ${hospitalList[index].hospitalId}",
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "User Name : ${widget.userName}",
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "New Date : ${hospitalList[index].appointmentDate}",
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
                                            looping: true,
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
                                                    content: Text(
                                                        "New will be $date"),
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
                                                                      "ArogyaSair/tblAppointment/${hospitalList[index].appointmentId}");
                                                          DatabaseEvent
                                                              databaseAppointmentEvent =
                                                              await dbAppointmentRef
                                                                  .once();
                                                          DataSnapshot
                                                              dataAppointmentSnapshot =
                                                              databaseAppointmentEvent
                                                                  .snapshot;
                                                          // print(dataAppointmentSnapshot);
                                                          Map dataAppointment =
                                                              dataAppointmentSnapshot
                                                                  .value as Map;
                                                          var hospitalkey =
                                                              hospitalList[
                                                                      index]
                                                                  .hospitalId;
                                                          var disease =
                                                              dataAppointment[
                                                                  "Disease"];
                                                          var Date = date;
                                                          var user =
                                                              hospitalList[
                                                                      index]
                                                                  .userId;
                                                          var status =
                                                              "Pending";

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
                                                              hospitalList[
                                                                      index]
                                                                  .id;
                                                          DatabaseReference
                                                              dbDelayedAppointmentRef =
                                                              FirebaseDatabase
                                                                  .instance
                                                                  .ref()
                                                                  .child(
                                                                      "ArogyaSair/tblDelayedAppointment/$delayedAppointmentId");
                                                          dbDelayedAppointmentRef
                                                              .remove();
                                                        },
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Cancel"),
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
                                                  "ArogyaSair/tblAppointment/${hospitalList[index].appointmentId}");
                                          DatabaseEvent
                                              databaseAppointmentEvent =
                                              await dbAppointmentRef.once();
                                          DataSnapshot dataAppointmentSnapshot =
                                              databaseAppointmentEvent.snapshot;
                                          // print(dataAppointmentSnapshot);
                                          Map dataAppointment =
                                              dataAppointmentSnapshot.value
                                                  as Map;
                                          // print(dataAppointment);
                                          final updatedAppointmentData = {
                                            "Status": "Approved",
                                          };
                                          dbAppointmentRef
                                              .update(updatedAppointmentData);
                                          var delayedAppointmentId =
                                              hospitalList[index].id;
                                          DatabaseReference
                                              dbDelayedAppointmentRef =
                                              FirebaseDatabase.instance.ref().child(
                                                  "ArogyaSair/tblDelayedAppointment/$delayedAppointmentId");
                                          // dbDelayedAppointmentRef.remove();
                                          final updatedDelayedAppointmentData =
                                              {
                                            "Status": "Approved",
                                          };
                                          dbDelayedAppointmentRef.update(
                                              updatedDelayedAppointmentData);
                                          DatabaseEvent
                                              databaseDelayedAppointmentEvent =
                                              await dbDelayedAppointmentRef
                                                  .once();
                                          DataSnapshot
                                              dataDelayedAppointmentSnapshot =
                                              databaseDelayedAppointmentEvent
                                                  .snapshot;
                                          Map dataDelayedAppointment =
                                              dataDelayedAppointmentSnapshot
                                                  .value as Map;
                                          DatabaseReference tblTreatment =
                                              FirebaseDatabase.instance
                                                  .ref()
                                                  .child(
                                                      "ArogyaSair/tblTreatment");
                                          HospitalTreatmentModel
                                              treatmentModelObject =
                                              HospitalTreatmentModel(
                                            dataDelayedAppointment[
                                                "DoctorName"],
                                            widget.userKey,
                                            dataAppointment["Disease"],
                                            dataAppointment["HospitalId"],
                                            dataDelayedAppointment["NewDate"],
                                          );
                                          tblTreatment.push().set(
                                              treatmentModelObject.toJson());
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
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("No Delayed Appointments"),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
