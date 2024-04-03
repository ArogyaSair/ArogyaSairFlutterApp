// ignore_for_file: non_constant_identifier_names, file_names, prefer_typing_uninitialized_variables

import 'package:arogyasair/MyPackages.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import 'models/BookedPackageInformation.dart';
import 'payment_configurations.dart' as payment_configurations;

class PaymentPage extends StatefulWidget {
  final String PackageName;
  final String Price;
  final String HospitalName;
  final String HospitalKey;
  final String Duration;
  final String Include;
  final String Date;
  final String Image;

  const PaymentPage(
      {super.key,
      required this.PackageName,
      required this.Price,
      required this.HospitalName,
      required this.Duration,
      required this.Include,
      required this.Image,
      required this.Date,
      required this.HospitalKey});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  DatabaseReference dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblBookedPackages');
  late String UserKey;
  final key = 'userKey';
  late var _paymentItems;

  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  void onGooglePayResult(paymentResult) {
    BookingPackagesInformationModel regobj = BookingPackagesInformationModel(
        widget.PackageName,
        widget.Price,
        widget.HospitalKey,
        widget.Duration,
        widget.Include,
        widget.Date,
        UserKey);

    dbRef2.push().set(regobj.toJson());
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyPackages()),
    );
    // debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('default_google_pay_config.json');
    _loadUserData();
    _paymentItems = [
      const PaymentItem(
        label: 'Total',
        amount: "200",
        status: PaymentItemStatus.final_price,
      )
    ];
  }

  Future<void> _loadUserData() async {
    String? Userkey = await getKey();
    setState(() {
      UserKey = Userkey!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff12d3c6),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:
            const Text("Check Out Page", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xfff2f6f7), Color(0xfff2f6f7)],
            ),
          ),
          child: Card(
            color: Colors.white,
            elevation: 3,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.Image,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
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
                    'Package Name:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.PackageName,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    'Duration:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.Duration,
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
                    widget.Date,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    'Include:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.Include,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text(
                    'Total Price:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "₹ ${widget.Price}",
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
        ),
      ),
    );
  }
}
