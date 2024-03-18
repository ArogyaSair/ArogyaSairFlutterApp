// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:pay/pay.dart';

import 'AppointmentInformation.dart';
import 'models/AppointmentDateSelectionModel.dart';
import 'models/DiseaseModel.dart';
import 'payment_configurations.dart' as payment_configurations;

class AppointmentDateSelection extends StatefulWidget {
  final DiseaseData item;
  final String HospitalName;
  final String HospitalKey;

  const AppointmentDateSelection(
      {super.key,
      required this.item,
      required this.HospitalName,
      required this.HospitalKey});

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

  late var _paymentItems;

  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  void onGooglePayResult(paymentResult) {
    var Hospitalkey = widget.HospitalKey;
    var HospitalName1 = widget.HospitalName;
    var Disease = widget.item.toString();
    var Date = birthDate;
    var User = UserKey;
    var Status = "Pending";
    if (birthDate != "Select Appointment Date") {
      AppointmentDateSelectionModel regobj = AppointmentDateSelectionModel(
          Hospitalkey, Disease, Date, User, Status);
      dbRef2.push().set(regobj.toJson());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppointmentInformation(
            HospitalName: HospitalName1,
            item: widget.item.toString(),
            Date: Date.toString(),
            Status: Status,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Date Selection"),
            content: const Text("Please Select Date for appointment"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "OK",
                ),
              )
            ],
          );
        },
      );
    }
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  void initState() {
    super.initState();
    controllerDateOfBirth = TextEditingController(text: birthDate);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('default_google_pay_config.json');
    String? HospitalKey = await getKey();
    setState(() {
      UserKey = HospitalKey!;
    });
    _paymentItems = [
      const PaymentItem(
        label: 'Total',
        amount: '100',
        status: PaymentItemStatus.final_price,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
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
                    widget.item.toString(),
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  // Add some vertical spacing
                  Text(
                    widget.HospitalName,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
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
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      fillColor: const Color(0xffE0E3E7),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FutureBuilder<PaymentConfiguration>(
                      future: _googlePayConfigFuture,
                      builder: (context, snapshot) => snapshot.hasData
                          ? GooglePayButton(
                              paymentConfiguration: snapshot.data!,
                              paymentItems: _paymentItems,
                              type: GooglePayButtonType.book,
                              margin: const EdgeInsets.only(top: 15.0),
                              onPaymentResult: onGooglePayResult,
                              loadingIndicator: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : ApplePayButton(
                              paymentConfiguration:
                                  PaymentConfiguration.fromJsonString(
                                      payment_configurations.defaultApplePay),
                              paymentItems: _paymentItems,
                              style: ApplePayButtonStyle.black,
                              type: ApplePayButtonType.book,
                              margin: const EdgeInsets.only(top: 15.0),
                              onPaymentResult: onApplePayResult,
                              loadingIndicator: const Center(
                                child: CircularProgressIndicator(),
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
