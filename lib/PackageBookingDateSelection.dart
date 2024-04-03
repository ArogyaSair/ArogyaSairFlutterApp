// ignore_for_file: file_names, non_constant_identifier_names

import 'package:arogyasair/Payment.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:arogyasair/src/fill_image_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PackageBookingDateSelection extends StatefulWidget {
  final String PackageName;
  final String Price;
  final String HospitalName;
  final String HospitalKey;
  final String Duration;
  final String Include;
  final String Image;

  const PackageBookingDateSelection(
      {super.key,
      required this.PackageName,
      required this.Price,
      required this.HospitalName,
      required this.Duration,
      required this.Include,
      required this.Image,
      required this.HospitalKey});

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
    _loadUserData();
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
        title: const Text(
          "Package Date Selection",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff12d3c6),
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
        titleSpacing: 1,
      ),
      // body: Container(
      //   color: const Color(0xfff2f6f7),
      //   child: Padding(
      //     padding: const EdgeInsets.all(20),
      //     child: FillImageCard(
      //       width: double.infinity,
      //       height: double.infinity,
      //       imageProvider: NetworkImage(
      //         imagePath = widget.Image,
      //       ),
      //       title: Text(widget.PackageName),
      //       description: Text(widget.Include),
      //       tags: [
      //         Text(widget.HospitalName),
      //         Text("${widget.Price} Rs./-"),
      //         Text("${widget.Duration} weeks for the treatment"),
      //
      //       ],
      //       footer: ElevatedButton(
      //         style: ElevatedButton.styleFrom(
      //           minimumSize: const Size(200, 50),
      //           elevation: 10,
      //           backgroundColor: const Color(0xff12d3c6),
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(12),
      //           ),
      //         ),
      //         onPressed: () {
      //           if (birthDate == "Select Appointment Date") {
      //             showDialog(
      //               context: context,
      //               barrierDismissible: false,
      //               builder: (context) {
      //                 return AlertDialog(
      //                   title: const Text("Alert Message"),
      //                   content: const Text("Please Select Date"),
      //                   actions: <Widget>[
      //                     TextButton(
      //                       child: const Text('OK'),
      //                       onPressed: () {
      //                         Navigator.pop(context);
      //                       },
      //                     ),
      //                   ],
      //                 );
      //               },
      //             );
      //           } else {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => PaymentPage(
      //                   PackageName: widget.PackageName,
      //                   Price: widget.Price,
      //                   HospitalName: widget.HospitalName,
      //                   Duration: widget.Duration,
      //                   Include: widget.Include,
      //                   Date: birthDate,
      //                   Image: widget.Image,
      //                   HospitalKey: widget.HospitalKey,
      //                 ),
      //               ),
      //             );
      //           }
      //         },
      //         child: const Text("Proceed for Payment",style: TextStyle(color: Colors.white)),
      //       ),
      //     ),
      //   ),
      // ),
      body: Container(
        color: const Color(0xfff2f6f7),
        padding: const EdgeInsets.all(20),
        child: FillImageCard(
          color: const Color(0xfff2f6f7),
          width: double.infinity,
          height: double.infinity,
          imageProvider: NetworkImage(
            imagePath = widget.Image,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.PackageName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8), // Add some gap here
              Text(
                widget.Include,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          tags: [
            _buildTagRow(FontAwesomeIcons.hospital, widget.HospitalName),
            _buildTagRow(FontAwesomeIcons.moneyBill, "${widget.Price} Rs./-"),
            _buildTagRow(
              FontAwesomeIcons.clock,
              "${widget.Duration} weeks for the treatment",
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
                    color: Color(0xff12d3c6),
                  ),
                ),
                // border: const OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(8)),
                //   borderSide: BorderSide(color: Colors.black),
                // ),
              ),
            ),
          ],
          footer: Padding(
            padding: const EdgeInsets.only(top: 20),
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
                      builder: (context) => PaymentPage(
                        PackageName: widget.PackageName,
                        Price: widget.Price,
                        HospitalName: widget.HospitalName,
                        Duration: widget.Duration,
                        Include: widget.Include,
                        Date: birthDate,
                        Image: widget.Image,
                        HospitalKey: widget.HospitalKey,
                      ),
                    ),
                  );
                }
              },
              child: const Text("Proceed for Payment",
                  style: TextStyle(color: Colors.white)),
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
      initialDate: DateTime.now().add(const Duration(days: 14)),
      lastDate: DateTime.now().add(const Duration(days: 44)),
      dateFormat: "dd-MM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: false,
    );
    setState(() {
      if (datePicked != null) {
        birthDate = "${datePicked.day}-${datePicked.month}-${datePicked.year}";
        // controllerDateOfBirth = TextEditingController(text: birthDate);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Booking Confirmation"),
                content: Text(birthDate),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      setState(() {
                        controllerDateOfBirth =
                            TextEditingController(text: birthDate);
                      });
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      setState(() {
                        birthDate = "Select Appointment Date";
                        controllerDateOfBirth =
                            TextEditingController(text: birthDate);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
      }
    });
  }

  Widget _buildTagRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          FaIcon(icon),
          const SizedBox(width: 20),
          Text(text),
        ],
      ),
    );
  }
}
