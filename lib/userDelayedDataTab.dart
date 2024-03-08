// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.orange,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            hospitalList[index].status,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
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
                                          // fixedSize: const Size(100,30 ),
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
