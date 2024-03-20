// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import 'AppointmentInformation.dart';
import 'models/AppointmentDateSelectionModel.dart';
import 'payment_configurations.dart' as payment_configurations;

class GeneralAppointmentPayment extends StatefulWidget {
  // const GeneralAppointmentPayment({super.key});
  final String item;
  final String HospitalName;
  final String HospitalKey;
  final String birthDate;

  const GeneralAppointmentPayment(
      {super.key,
      required this.item,
      required this.HospitalName,
      required this.HospitalKey,
      required this.birthDate});

  @override
  State<GeneralAppointmentPayment> createState() =>
      _GeneralAppointmentPaymentState();
}

class _GeneralAppointmentPaymentState extends State<GeneralAppointmentPayment> {
  late var _paymentItems;
  late String UserKey;
  final key = 'userKey';
  late bool containsKey;
  DatabaseReference dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblAppointment');
  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  @override
  void initState() {
    super.initState();
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

  void onGooglePayResult(paymentResult) {
    var Hospitalkey = widget.HospitalKey;
    var HospitalName1 = widget.HospitalName;
    var Disease = widget.item.toString();
    var Date = widget.birthDate;
    var User = UserKey;
    var Status = "Pending";
    if (Date != "Select Appointment Date") {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Page"),
      ),
      body: Card(
        elevation: 3,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hospital Name:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.HospitalName,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const Text(
                'Appointment For Name:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "General Checkup",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const Text(
                'Date:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.birthDate,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              const Text(
                'Payable amount now:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "₹ 200",
                style: TextStyle(
                  fontSize: 14,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
