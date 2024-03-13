// ignore_for_file: file_names, non_constant_identifier_names

import 'package:arogyasair/saveSharePreferences.dart';
import 'package:arogyasair/src/fill_image_card.dart';
import 'package:flutter/material.dart';

import 'PackageBookingDateSelection.dart';

class PackageDetails extends StatefulWidget {
  final String PackageName;
  final String Price;
  final String HospitalName;
  final String Duration;
  final String Inculde;
  final String Image;

  const PackageDetails(
      {Key? key,
      required this.PackageName,
      required this.Price,
      required this.HospitalName,
      required this.Duration,
      required this.Inculde,
      required this.Image})
      : super(key: key);

  @override
  State<PackageDetails> createState() => _PackageBookingDetailsState();
}

class _PackageBookingDetailsState extends State<PackageDetails> {
  late String imagePath;

  late String UserKey;
  final key = 'userKey';

  @override
  void initState() {
    super.initState();
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FillImageCard(
          width: double.infinity,
          height: double.infinity,
          imageProvider: NetworkImage(
            imagePath = widget.Image,
          ),
          title: Text(widget.PackageName),
          description: Text(widget.Inculde),
          tags: [
            Text(widget.HospitalName),
            Text("${widget.Price} Rs./-"),
            Text("${widget.Duration} weeks"),
          ],
          footer: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PackageBookingDateSelection(
                    PackageName: widget.PackageName,
                    Price: widget.Price,
                    HospitalName: widget.HospitalName,
                    Duration: widget.Duration,
                    Incude: widget.Inculde,
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
