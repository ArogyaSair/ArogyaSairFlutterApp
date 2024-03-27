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
          "Appointments",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade900,
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
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Align content to the left
                      children: [
                        Row(
                          children: [
                            const Text(
                              "For: ",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.item.toString(),
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        // Add some vertical spacing
                        Row(
                          children: [
                            const FaIcon(FontAwesomeIcons.hospital),
                            const SizedBox(width: 5.0),
                            Text(
                              widget.HospitalName.toString(),
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
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
                                color: Colors.blue,
                              ),
                            ),
                            // filled: true,
                            // fillColor: const Color(0xffE0E3E7),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            elevation: 10,
                            backgroundColor: Colors.blue,
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
                                    content: const Text("Please Select Date"),
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
