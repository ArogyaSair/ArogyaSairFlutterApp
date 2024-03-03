// ignore_for_file: file_names, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'package:arogyasair/HospitalHomePage.dart';
import 'package:arogyasair/models/HospitalTreatmentModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:logger/logger.dart';

class HospitalAppointmentDetail extends StatefulWidget {
  final appointments;
  final userData;
  final hospitalKey;

  const HospitalAppointmentDetail(
      this.appointments, this.userData, this.hospitalKey,
      {Key? key})
      : super(key: key);

  @override
  State<HospitalAppointmentDetail> createState() =>
      _HospitalAppointmentDetailState();
}

class _HospitalAppointmentDetailState extends State<HospitalAppointmentDetail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Map data1;
  late Map data2;
  late Query dbRef;
  var logger = Logger();
  late String hospitalKey;
  late String date;
  late TextEditingController newDate = TextEditingController();
  List<String> hospitals = [];
  List<Map> appointment = [];
  late List<String> listOfValuesForKey1;
  late String? selectedDoctor;

  Future<void> getHospitalData() async {
    listOfValuesForKey1 = ['Select Doctor'];
    selectedDoctor = 'Select Doctor';
    hospitalKey = widget.hospitalKey;
    Query dbRef =
        FirebaseDatabase.instance.ref().child("ArogyaSair/tblHospitalDoctor");
    dbRef
        .orderByChild("Hospital_ID")
        .equalTo(widget.hospitalKey)
        .onValue
        .listen((event) {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        values.forEach((key, value) {
          listOfValuesForKey1.add(value['Doctor']);
        });
        print(listOfValuesForKey1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment Detail"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<void>(
          future: getHospitalData(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Patient Name : ${widget.userData['UserName']}"),
                                const SizedBox(width: 10),
                                Text("Patient Key : ${widget.userData['Key']}"),
                                const SizedBox(width: 10),
                                Text(
                                    "Requested date of visit : ${widget.appointments['AppointmentDate']}"),
                                const SizedBox(width: 10),
                                Text("For : ${widget.appointments["Disease"]}"),
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
                                Text("Key : ${widget.appointments["Key"]}"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Select Doctor';
                                      }
                                      return null;
                                    },
                                    controller: newDate,
                                    enabled: false,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
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
                                  child: DropdownButton(
                                    value: selectedDoctor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    style: const TextStyle(color: Colors.black),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    items:
                                        listOfValuesForKey1.map((String items) {
                                      return DropdownMenuItem(
                                          value: items, child: Text(items));
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedDoctor = newValue;
                                        if (newValue == "Select Doctor") {
                                          newDate = TextEditingController();
                                        } else {
                                          newDate = TextEditingController(
                                            text: "Dr.$newValue",
                                          );
                                        }
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (widget.appointments["Status"] ==
                                                "Pending") {}
                                            approveAppointment();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                        ),
                                        child: const Text(
                                          'Approve',
                                          style: TextStyle(color: Colors.white),
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
                                          _getDate(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                        ),
                                        child: const Text(
                                          'Delay',
                                          style: TextStyle(color: Colors.white),
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
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<void> approveAppointment() async {
    var appointmentKey = widget.appointments["Key"];
    print(appointmentKey);
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
      newDate.text,
      widget.userData["Key"],
      widget.appointments["Disease"],
      hospitalKey,
      widget.appointments["AppointmentDate"],
    );
    tblTreatment.push().set(treatmentModelObject.toJson());
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HospitalHomePage(2),
      ),
    );
  }

  Future<void> delayAppointment() async {
    print(widget.appointments["Key"]);
    var appointmentKey = widget.appointments["Key"];
    print(appointmentKey);
    final updatedData = {
      "AppointmentDate": date,
      "Status": "Delayed",
    };
    final userRef = FirebaseDatabase.instance
        .ref()
        .child("ArogyaSair/tblAppointment")
        .child(appointmentKey);
    await userRef.update(updatedData);
  }

  Future<void> _getDate(BuildContext context) async {
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2090),
      dateFormat: "dd-MM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );
    setState(() {
      if (datePicked != null) {
        date = "${datePicked.day}-${datePicked.month}-${datePicked.year}";
        newDate =
            TextEditingController(text: "New date for this patient is $date");
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Alert Message"),
              content: Text(newDate.text),
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
                )
              ],
            );
          },
        );
      }
    });
  }
}
