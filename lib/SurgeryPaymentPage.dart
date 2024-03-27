// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:arogyasair/Notifications/hospital_appointment_request_notification.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import 'AppointmentInformation.dart';
import 'models/AppointmentDateSelectionModel.dart';
import 'models/SurgeryData.dart';
import 'payment_configurations.dart' as payment_configurations;

class SurgeryPaymentPage extends StatefulWidget {
  final SurgeryModel item;
  final String HospitalName;
  final String HospitalKey;
  final String birthDate;

  const SurgeryPaymentPage(
      {super.key,
      required this.item,
      required this.HospitalName,
      required this.HospitalKey,
      required this.birthDate});

  @override
  State<SurgeryPaymentPage> createState() => _SurgeryPaymentPageState();
}

class _SurgeryPaymentPageState extends State<SurgeryPaymentPage> {
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
    var Date = widget.birthDate;
    var User = UserKey;
    var Status = "Pending";
    AppointmentDateSelectionModel regobj =
        AppointmentDateSelectionModel(Hospitalkey, Disease, Date, User, Status);
    dbRef2.push().set(regobj.toJson());
    sendNotificationToHospital(
        appointmentDate: Date,
        disease: Disease,
        hospitalKey: Hospitalkey,
        status: Status);
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
        amount: '200',
        status: PaymentItemStatus.final_price,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
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
              Text(
                widget.item.toString(),
                style: const TextStyle(
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
