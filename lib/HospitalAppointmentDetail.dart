// ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:arogyasair/HospitalHomePage.dart';
import 'package:arogyasair/Notifications/user_appointment_request_approve_notification.dart';
import 'package:arogyasair/Notifications/user_appointment_request_delay_notification.dart';
import 'package:arogyasair/models/HospitalAppointmentDelayedModel.dart';
import 'package:arogyasair/models/HospitalTreatmentModel.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class HospitalAppointmentDetail extends StatefulWidget {
  final appointments;
  final userData;
  final hospitalKey;

  const HospitalAppointmentDetail(
      this.appointments, this.userData, this.hospitalKey,
      {super.key});

  @override
  State<HospitalAppointmentDetail> createState() =>
      _HospitalAppointmentDetailState();
}

class _HospitalAppointmentDetailState extends State<HospitalAppointmentDetail> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Map data1;
  late Map data2;
  late Query dbRef;
  late String hospitalKey;
  late String hospitalName;
  late String date;
  TimeOfDay? selectedTimeFrom;
  late String newDate;
  String timeFrom = "From";
  List<String> hospitals = [];
  List<Map> appointment = [];
  late List<String> listOfValuesForKey1;
  TextEditingController visitingTime =
      TextEditingController(text: "Tap to select time for patient's visit");
  List<Map<String, dynamic>> doctorMap = [
    {'Key': 'Null', 'DoctorName': 'Select Doctor'}
  ];
  List<Map<String, dynamic>> displayDoctorMap = [];
  Map<dynamic, dynamic>? userData;
  Map<dynamic, dynamic>? hospitalDoctorData;
  List hospitalDoctorMap = [];
  int myCount = 0;
  String? selectedDoctor = "Select Doctor";
  late Future<void> _hospitalDataFuture;

  @override
  void initState() {
    super.initState();
    _hospitalDataFuture = getHospitalData();
    loadUSer();
  }

  Future<void> loadUSer() async {
    String? hospitalName = await getData("HospitalName");
    newDate = "Select Doctor";
    setState(() {
      this.hospitalName = hospitalName!;
    });
  }

  Future<void> fetchUserData(String key, int length) async {
    DatabaseReference dbUserData =
        FirebaseDatabase.instance.ref().child("ArogyaSair/tblDoctor/$key");
    DatabaseEvent userDataEvent = await dbUserData.once();
    DataSnapshot userDataSnapshot = userDataEvent.snapshot;
    userData = userDataSnapshot.value as Map?;
    displayDoctorMap.add({
      "Key": key,
      "DoctorName": userData!["DoctorName"],
    });
  }

  Future<void> getHospitalData() async {
    hospitalKey = widget.hospitalKey;
    dbRef =
        FirebaseDatabase.instance.ref().child("ArogyaSair/tblHospitalDoctor");
    displayDoctorMap.clear();
    displayDoctorMap.add({
      'Key': 'Select Doctor',
      'DoctorName': 'Select Doctor'
    }); // Add the first element
    await dbRef
        .orderByChild("Hospital_ID")
        .equalTo(widget.hospitalKey)
        .once()
        .then((event) {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        values.forEach((key, value) async {
          hospitalDoctorMap.add({
            "key": value["Doctor"],
            "timeFrom": value["TimeFrom"],
            "timeTo": value["TimeTo"],
          });
          await fetchUserData(value["Doctor"], values.length);
        });
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment Detail"),
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: _hospitalDataFuture,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (displayDoctorMap.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Patient Name : ${widget.userData['UserName']}"),
                                  const SizedBox(width: 10),
                                  Text(
                                      "Requested date of visit : ${widget.appointments['AppointmentDate']}"),
                                  const SizedBox(width: 10),
                                  Text(
                                      "For : ${widget.appointments["Disease"]}"),
                                  const SizedBox(width: 10),
                                  Text(
                                      "Request status : ${widget.appointments["Status"]}"),
                                  const SizedBox(width: 10),
                                  Text(
                                      "Patient blood group : ${widget.userData["BloodGroup"]}"),
                                  const SizedBox(width: 10),
                                  Text(
                                      "Contact Email : ${widget.userData["Email"]}"),
                                  const SizedBox(width: 10),
                                  Text(
                                      "Contact Number : ${widget.userData["ContactNumber"]}"),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 44,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: DropdownButton<String>(
                                      value: selectedDoctor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      icon: const Icon(Icons.arrow_drop_down),
                                      items: displayDoctorMap
                                          .map<DropdownMenuItem<String>>(
                                              (Map<String, dynamic> doctor) {
                                        return DropdownMenuItem<String>(
                                          value: doctor["Key"],
                                          child: Text(doctor["DoctorName"]),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedDoctor = newValue;
                                          newDate = selectedDoctor!;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    child: TextFormField(
                                      enabled: false,
                                      controller: visitingTime,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.watch_later),
                                          disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          )),
                                    ),
                                    onTap: () {
                                      getTime();
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "*15 minutes from the time you choose will be assigned for the patients",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 44.0,
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Color(0xFF0D47A1),
                                              Colors.lightBlue
                                            ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            approveAppointment();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: const Text(
                                            'Approve',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 44.0,
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Color(0xFF0D47A1),
                                              Colors.lightBlue
                                            ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (newDate == "Select Doctor") {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Alert Message"),
                                                    content: const Text(
                                                        "Please select doctor for this patient."),
                                                    actions: <Widget>[
                                                      OutlinedButton(
                                                        child: const Text('OK'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              _getDate(context);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: const Text(
                                            'Delay',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<void> approveAppointment() async {
    if (newDate == "Select Doctor") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Alert Message"),
            content: const Text("Please select doctor for this patient."),
            actions: <Widget>[
              OutlinedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    } else {
      var appointmentKey = widget.appointments["Key"];
      final updatedData = {
        "Status": "Approved",
      };
      final userRef = FirebaseDatabase.instance
          .ref()
          .child("ArogyaSair/tblAppointment")
          .child(appointmentKey);
      await userRef.update(updatedData);
      DatabaseReference tblTreatment =
          FirebaseDatabase.instance.ref().child("ArogyaSair/tblTreatment");
      HospitalTreatmentModel treatmentModelObject = HospitalTreatmentModel(
          newDate,
          widget.userData["Key"],
          widget.appointments["Disease"],
          hospitalKey,
          widget.appointments["Key"],
          widget.appointments["AppointmentDate"],
          "Approved",
          visitingTime.text);
      tblTreatment.push().set(treatmentModelObject.toJson());

      sendAppointmentApprovalToUser(
          userKey: widget.userData["Key"],
          appointmentDate: widget.appointments["AppointmentDate"],
          disease: widget.appointments["Disease"],
          status: "Approved",
          hospitalName: hospitalName,
          time: visitingTime.text);

      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HospitalHomePage(2),
        ),
      );
    }
  }

  Future<void> delayAppointment() async {
    if (newDate == "Select Doctor") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Alert Message"),
            content: const Text("Please select doctor for this patient."),
            actions: <Widget>[
              OutlinedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    } else {
      var appointmentKey = widget.appointments["Key"];
      final updatedData = {
        "AppointmentDate": date,
        "Status": "Delayed",
      };
      final userRef = FirebaseDatabase.instance
          .ref()
          .child("ArogyaSair/tblAppointment")
          .child(appointmentKey);
      await userRef.update(updatedData);

      sendAppointmentDelayToUser(
          userKey: widget.userData["Key"],
          appointmentDate: widget.appointments["AppointmentDate"],
          disease: widget.appointments["Disease"],
          status: "Approved",
          hospitalName: hospitalName,
          newDate: date,
          time: visitingTime.text);

      DatabaseReference tblDelayedAppointment = FirebaseDatabase.instance
          .ref()
          .child("ArogyaSair/tblDelayedAppointment");
      var oldDate = widget.appointments['AppointmentDate'];
      var userKey = widget.userData['Key'];
      HospitalAppointmentDelayedModel hospitalAppointmentDelayedModel =
          HospitalAppointmentDelayedModel(
              widget.appointments['Key'],
              date,
              newDate,
              hospitalKey,
              oldDate,
              userKey,
              "Delayed",
              visitingTime.text);
      tblDelayedAppointment
          .push()
          .set(hospitalAppointmentDelayedModel.toJson());
    }
  }

  Future<void> _getDate(BuildContext context) async {
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 14)),
      dateFormat: "dd-MM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );
    setState(() {
      if (datePicked != null) {
        date = "${datePicked.day}-${datePicked.month}-${datePicked.year}";
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Alert Message"),
              content: Text("New will be $date"),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    delayAppointment();
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HospitalHomePage(2),
                      ),
                    );
                  },
                ),
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  Future<void> getTime() async {
    if (selectedDoctor == "Select Doctor") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Please select doctor first"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok")),
            ],
          );
        },
      );
    } else {
      var doctorId = selectedDoctor;
      var timeToCheck;
      var toTime;
      for (var element in hospitalDoctorMap) {
        if (element["key"] == doctorId) {
          timeToCheck = stringToTimeOfDay(element["timeFrom"]);
          toTime = stringToTimeOfDay(element["timeTo"]);
        }
      }
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: selectedTimeFrom ??
            TimeOfDay(hour: timeToCheck.hour, minute: timeToCheck.minute),
        initialEntryMode: TimePickerEntryMode.dial,
        orientation: Orientation.portrait,
      );

      setState(() {
        if (time!.hour < toTime.hour) {
          timeFrom = '${time.hourOfPeriod}:${time.minute}'; // Update timeFrom
          selectedTimeFrom = time;
          // Adding 20 minutes to selectedTimeFrom
          var newTime = TimeOfDay(
            hour: time.hour,
            minute: time.minute + 15,
          );

          // Handling overflow if minutes exceed 60
          if (newTime.minute >= 60) {
            final int overflowHours = newTime.minute ~/ 60;
            newTime = TimeOfDay(
              hour: newTime.hour + overflowHours,
              minute: newTime.minute % 60,
            );
          }

          visitingTime.text =
              "$timeFrom to ${newTime.hourOfPeriod}:${newTime.minute}";
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Doctor is not available for this time."),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Doctor's time is :- ${timeToCheck.hour}:${timeToCheck.minute} to ${toTime.hour}:${toTime.minute}."),
                    const Text("Please select between this time."),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'))
                ],
              );
            },
          );
        }
      });
    }
  }

  TimeOfDay stringToTimeOfDay(String timeString) {
    final List<String> parts = timeString.split(':');
    final int hour = int.parse(parts[0]);
    final int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
