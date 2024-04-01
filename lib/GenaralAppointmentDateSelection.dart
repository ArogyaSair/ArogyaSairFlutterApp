// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:arogyasair/GeneralAppointmentPayment.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class GeneralAppointmentDateSelection extends StatefulWidget {
  final String item;
  final String HospitalName;
  final String HospitalKey;

  const GeneralAppointmentDateSelection(
      {super.key,
      required this.item,
      required this.HospitalName,
      required this.HospitalKey});

  @override
  State<GeneralAppointmentDateSelection> createState() =>
      _GeneralAppointmentDateSelectionState();
}

class _GeneralAppointmentDateSelectionState
    extends State<GeneralAppointmentDateSelection> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Appointment",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xfff2f6f7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              color: const Color(0xfff2f6f7),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // Align content to the left
                        children: [
                          const Center(
                            child: FaIcon(
                              FontAwesomeIcons.hospital,
                              color: Color(0xff12d3c6),
                              size: 50,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      widget.HospitalName.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 70, right: 20),
                            child: Row(
                              children: [
                                const Text(
                                  "Surgery For: ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.item.toString(),
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          // Add some vertical spacing
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: TextFormField(
                              controller: controllerDateOfBirth,
                              readOnly: true,

                              // Make the text input read-only
                              decoration: InputDecoration(
                                prefixIcon: GestureDetector(
                                  onTap: () {
                                    _getDate(context);
                                  },
                                  child: const Icon(
                                    Icons.date_range,
                                    color: const Color(0xff12d3c6),
                                  ),
                                ),
                                // filled: true,
                                // fillColor: const Color(0xffE0E3E7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 80, right: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200, 50),
                                elevation: 10,
                                backgroundColor: const Color(0xff12d3c6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                if (birthDate == "Select Appointment Date") {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Alert Message"),
                                        content:
                                            const Text("Please Select Date"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GeneralAppointmentPayment(
                                        HospitalKey: widget.HospitalKey,
                                        HospitalName: widget.HospitalName,
                                        item: widget.item,
                                        key: widget.key,
                                        birthDate: birthDate,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: const Text("Proceed for Payment",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(65),
                            child: SizedBox(
                              child: Center(
                                // Center the Lottie animation
                                child: Lottie.asset(
                                  'assets/Animation/booking_payment.json',
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getDate(BuildContext context) async {
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      firstDate: DateTime.now().add(const Duration(days: 2)),
      initialDate: DateTime.now().add(const Duration(days: 2)),
      lastDate: DateTime.now().add(const Duration(days: 9)),
      dateFormat: "dd-MM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: false,
    );
    setState(() {
      if (datePicked != null) {
        birthDate = "${datePicked.day}-${datePicked.month}-${datePicked.year}";
        controllerDateOfBirth = TextEditingController(text: birthDate);
      }
    });
  }
}
