// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:arogyasair/models/user_updates_show.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
              .child("ArogyaSair/tblAppointment")
              .onValue,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
              List<UserUpdateShow> hospitalList = [];
              hospitalList.clear();
              map.forEach((key, value) {
                if (value["UserId"] == widget.userKey) {
                  if (value["Status"] == "Delayed") {
                    hospitalList.add(UserUpdateShow.fromMap(value, key));
                  }
                }
              });
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
                                  "Appointment for : ${hospitalList[index].disease}",
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
                                  "Appointment Date : ${hospitalList[index].appointmentDate}",
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    fixedSize: const Size(151, 40),
                                  ),
                                  child: Text(
                                    hospitalList[index].status,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
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
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
