// ignore_for_file: file_names, non_constant_identifier_names

import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';

import 'AppointmentInformation.dart';
import 'models/AppointmentDateSelectionModel.dart';

class AppointmentDateSelection extends StatefulWidget {
  final String item;
  final String HospitalName;
  final String HospitalKey;

  const AppointmentDateSelection(
      {Key? key,
      required this.item,
      required this.HospitalName,
      required this.HospitalKey})
      : super(key: key);

  @override
  State<AppointmentDateSelection> createState() =>
      _AppointmentDateSelectionState();
}

class _AppointmentDateSelectionState extends State<AppointmentDateSelection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DatabaseReference dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblAppointment');
  var birthDate = "Select Appointment Date";
  TextEditingController controllerDateOfBirth = TextEditingController();
  TextEditingController controllerStatus = TextEditingController();
  late String UserKey;
  final key = 'userKey';
  late bool containsKey;

  @override
  void initState() {
    super.initState();
    controllerDateOfBirth = TextEditingController(text: birthDate);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? HospitalKey = await getKey();
    setState(() {
      UserKey = HospitalKey!;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("key ${widget.HospitalKey}");
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Packages",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(1),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Align content to the left
                    children: [
                      Text(
                        widget.item,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0), // Add some vertical spacing
                      Text(
                        widget.HospitalName,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: controllerDateOfBirth,
                        readOnly: true, // Make the text input read-only
                        decoration: InputDecoration(
                          prefixIcon: GestureDetector(
                            onTap: () {
                              _getDate(context);
                            },
                            child: const Icon(
                              Icons.date_range,
                              color: Colors.blue,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          filled: true,
                          fillColor: const Color(0xffE0E3E7),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            var Hospitalkey = widget.HospitalKey;
                            var HospitalName1 = widget.HospitalName;
                            var Disease = widget.item;
                            var Date = birthDate;
                            var User = UserKey;
                            var Status = "Pending";

                            AppointmentDateSelectionModel regobj =
                                AppointmentDateSelectionModel(
                                    Hospitalkey, Disease, Date, User, Status);
                            dbRef2.push().set(regobj.toJson());
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AppointmentInformation(
                                            HospitalName: HospitalName1,
                                            item: widget.item,
                                            Date: Date.toString(),
                                            Status: Status)));
                          }
                        },
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  Future<void> _getDate(BuildContext context) async {
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2090),
      dateFormat: "dd-MM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );
    setState(() {
      if (datePicked != null) {
        birthDate = "${datePicked.day}-${datePicked.month}-${datePicked.year}";
        controllerDateOfBirth = TextEditingController(text: birthDate);
      }
    });
  }
}
