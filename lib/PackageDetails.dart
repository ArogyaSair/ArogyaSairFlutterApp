// ignore_for_file: file_names, non_constant_identifier_names

import 'package:arogyasair/saveSharePreferences.dart';
import 'package:arogyasair/src/fill_image_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'BookedPackageInformation.dart';
import 'contact.dart';
// import 'models/BookedPackageInformation.dart';

class PackageDetails extends StatefulWidget {
  final String PackageName;
  final String Price;
  final String HospitalName;
  final String Duration;
  final String Incude;
  final String Image;

  const PackageDetails(
      {Key? key,
      required this.PackageName,
      required this.Price,
      required this.HospitalName,
      required this.Duration,
      required this.Incude,
      required this.Image})
      : super(key: key);

  @override
  State<PackageDetails> createState() => _PackageBookingDetailsState();
}

class _PackageBookingDetailsState extends State<PackageDetails> {
  late String imagePath;
  DatabaseReference dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblBookedPackages');

  late String UserKey;
  final key = 'userKey';

  @override
  void initState() {
    super.initState();
    // controllerDateOfBirth = TextEditingController(text: birthDate);
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
    // return Scaffold(
    //   body: Center(
    //     child: Card(
    //       child: Row(
    //         children: [
    //           Expanded(
    //             child: Column(
    //               children: [
    //                 Column(
    //                   children: [
    //                     ClipRRect(
    //                       borderRadius: BorderRadius.circular(50),
    //                       child: Image.network(
    //                         imagePath = widget.Image,
    //                         height: 120,
    //                         width: 120,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 10),
    //                       child: Text(widget.PackageName),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 10),
    //                       child: Text(widget.Price),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 10),
    //                       child: Text(widget.Duration),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 10),
    //                       child: Text(widget.HospitalName),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 10),
    //                       child: Text(widget.Incude),
    //                     ),
    //                     Padding(
    //                         padding: EdgeInsets.only(top: 30),
    //                         child: Container(
    //                           height: 44.0,
    //                           decoration: const BoxDecoration(
    //                               gradient: LinearGradient(colors: [
    //                                 Color(0xFF0D47A1),
    //                                 Colors.lightBlue
    //                               ]),
    //                               borderRadius: BorderRadius.all(
    //                                   Radius.circular(20))),
    //                           child: ,
    //                         ),),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: FillImageCard(
          width: 200,
          imageProvider: NetworkImage(
            imagePath = widget.Image,
          ),
          title: Text(widget.PackageName),
          description: Text(widget.Incude),
          tags: [
            Text(widget.HospitalName),
            Text("${widget.Price} Rs./-"),
            Text("${widget.Duration} weeks")
          ],
          footer: ElevatedButton(
            onPressed: () {
              BookingPackagesInformationModel regobj =
                  BookingPackagesInformationModel(
                      widget.PackageName,
                      widget.Price,
                      widget.HospitalName,
                      widget.Duration,
                      widget.Incude,
                      UserKey);
              dbRef2.push().set(regobj.toJson());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => contact(
                    PackageName: widget.PackageName,
                    Price: widget.Price,
                    HospitalName: widget.HospitalName,
                    Duration: widget.Duration,
                    Incude: widget.Incude,
                    Image: widget.Image,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shadowColor: Colors.transparent,
            ),
            child: const Text(
              'Book',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
