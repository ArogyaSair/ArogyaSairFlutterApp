// ignore_for_file: file_names

import 'dart:async';
import 'dart:math';

import 'package:arogyasair/userHospitalDetails.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late Query dbRef;
  TextEditingController searchController = TextEditingController();
  late StreamController<List<Map>> _streamController;
  String searchValue = '';
  Timer? _debounce;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Map>>();
    dbRef = FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospital');
    _updateList('');

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.repeat();
        }
      });

    _animationController.forward();
  }

  void _updateList(String query) {
    // Cancel the previous debounce timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Create a new debounce timer
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Convert the query to lowercase for case-insensitive search
      String lowercaseQuery = query.toLowerCase();

      dbRef.orderByChild("HospitalName").onValue.listen((event) {
        Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
        List<Map> hospitals = [];
        if (values != null) {
          values.forEach((key, value) {
            // Check if the value has a 'Photo' field and it is not empty
            if (value['Photo'] != null &&
                value['Photo'].toString().isNotEmpty) {
              // Convert the HospitalName to lowercase for case-insensitive comparison
              String hospitalNameLowerCase =
                  (value['HospitalName'] as String?)?.toLowerCase() ?? '';

              // Check if the lowercase version of HospitalName contains the lowercase query
              if (hospitalNameLowerCase.contains(lowercaseQuery)) {
                hospitals.add(Map.from(value));
              }
            } else {
              hospitals.add({
                'HospitalName': value['HospitalName'],
                'HospitalCity': value['HospitalCity'],
                'Email': value['Email'],
                'Photo': 'noimage',
                // Placeholder value
              });
            }
          });
        }
        _streamController.add(hospitals);
        _animationController.stop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CupertinoSearchTextField(
          controller: searchController,
          autofocus: true,
          onChanged: (String value) {
            setState(() {
              searchValue = value;
              _updateList(searchValue);
            });
          },
          autocorrect: true,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          StreamBuilder<List<Map>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CustomPaint(
                    painter: MyCustomPainter(_animation.value),
                    child: Container(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Map>? hospitals = snapshot.data;
                if (hospitals != null && hospitals.isNotEmpty) {
                  return ListView.builder(
                    itemCount: hospitals.length,
                    itemBuilder: (context, index) {
                      Map data1 = hospitals[index];
                      var imageName = data1['Photo'] == 'noimage'
                          ? 'noimage'
                          : "HospitalImage%2F${data1['Photo']}";
                      var imagePath = data1['Photo'] == 'noimage'
                          ? 'https://via.placeholder.com/150' // Placeholder image URL
                          : "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/$imageName?alt=media";
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HospitalDetails(hospitalKey: data1["Email"]),
                            ),
                          );
                        },
                        contentPadding: const EdgeInsets.all(1),
                        leading: Image.network(imagePath),
                        title: Text(data1['HospitalName'].toString()),
                        subtitle: Text(data1['HospitalCity'].toString()),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No hospitals found'));
                }
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    _debounce?.cancel(); // Cancel the debounce timer to prevent memory leaks
    _animationController.dispose();
    super.dispose();
  }
}

class MyCustomPainter extends CustomPainter {
  final double animationValue;

  MyCustomPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (int value = 3; value >= 0; value--) {
      circle(canvas, Rect.fromLTRB(0, 0, size.width, size.height),
          value + animationValue);
    }
  }

  void circle(Canvas canvas, Rect rect, double value) {
    Paint paint = Paint()
      ..color = Colors.blueGrey.withOpacity((1 - (value / 4)).clamp(.0, 1));

    canvas.drawCircle(rect.center,
        sqrt((rect.width * .5 * rect.width * .5) * value / 4), paint);
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return true;
  }
}
