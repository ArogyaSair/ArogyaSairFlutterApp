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
  final String Include;
  final String Image;
  final String HospitalKey;

  const PackageDetails({super.key,
      required this.PackageName,
      required this.Price,
      required this.HospitalName,
      required this.Duration,
      required this.Include,
      required this.Image,
      required this.HospitalKey});

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
      appBar: AppBar(
        title: const Text(
          "Package Details",
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
      body: Container(
        color: const Color(0xfff2f6f7),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FillImageCard(
            width: double.infinity,
            height: double.infinity,
            imageProvider: NetworkImage(
              imagePath = widget.Image,
            ),
            title: Text(widget.PackageName),
            description: Text(widget.Include),
            tags: [
              Text(widget.HospitalName),
              Text("${widget.Price} Rs./-"),
              Text("${widget.Duration} weeks for the treatment"),
            ],
            footer: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                elevation: 10,
                backgroundColor: const Color(0xff12d3c6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PackageBookingDateSelection(
                      PackageName: widget.PackageName,
                      Price: widget.Price,
                      HospitalName: widget.HospitalName,
                      Duration: widget.Duration,
                      Include: widget.Include,
                      Image: widget.Image,
                      HospitalKey: widget.HospitalKey,
                    ),
                  ),
                );
              },
              child: const Text(
                'Book',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
