// ignore_for_file: file_names, non_constant_identifier_names, unused_field

import 'package:arogyasair/saveSharePreferences.dart';
import 'package:arogyasair/src/fill_image_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:pay/pay.dart';

class PackageBookingDateSelection extends StatefulWidget {
  final String PackageName;
  final String Price;
  final String HospitalName;
  final String Duration;
  final String Incude;
  final String Image;

  const PackageBookingDateSelection(
      {Key? key,
      required this.PackageName,
      required this.Price,
      required this.HospitalName,
      required this.Duration,
      required this.Incude,
      required this.Image})
      : super(key: key);

  @override
  State<PackageBookingDateSelection> createState() =>
      _PackageBookingDateSelectionState();
}

class _PackageBookingDateSelectionState
    extends State<PackageBookingDateSelection> {
  late String imagePath;
  DatabaseReference dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblBookedPackages');
  var birthDate = "Select Appointment Date";
  TextEditingController controllerDateOfBirth = TextEditingController();
  late String UserKey;
  final key = 'userKey';

  @override
  void initState() {
    super.initState();
    controllerDateOfBirth = TextEditingController(text: birthDate);
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('default_google_pay_config.json');
    _loadUserData();
  }

  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  Future<void> _loadUserData() async {
    String? Userkey = await getKey();
    setState(() {
      UserKey = Userkey!;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.Image);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FillImageCard(
          width: double.infinity,
          height: double.infinity,
          imageProvider: NetworkImage(
            imagePath = widget.Image,
          ),
          title: Text(widget.PackageName),
          description: Text(widget.Incude),
          tags: [
            Text(widget.HospitalName),
            Text("${widget.Price} Rs./-"),
            Text("${widget.Duration} weeks"),
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
          ],
          footer: ElevatedButton(
            onPressed: () {
              // var Date = birthDate;
              // BookingPackagesInformationModel regobj =
              //     BookingPackagesInformationModel(
              //         widget.PackageName,
              //         widget.Price,
              //         widget.HospitalName,
              //         widget.Duration,
              //         widget.Incude,
              //         Date,
              //         UserKey);
              // dbRef2.push().set(regobj.toJson());
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => contact(
              //       PackageName: widget.PackageName,
              //       Price: widget.Price,
              //       HospitalName: widget.HospitalName,
              //       Duration: widget.Duration,
              //       Incude: widget.Incude,
              //       Image: widget.Image,
              //     ),
              //   ),
              // );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shadowColor: Colors.transparent,
            ),
            child: const Text(
              'Confirm',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getDate(BuildContext context) async {
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      firstDate: DateTime.now().add(const Duration(days: 14)),
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
