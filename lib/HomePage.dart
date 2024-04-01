// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:arogyasair/DisplayHospitals.dart';
import 'package:arogyasair/drawerSideNavigation.dart';
import 'package:arogyasair/firebase_api.dart';
import 'package:arogyasair/get_home_data.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:arogyasair/src/fill_image_card.dart';
import 'package:arogyasair/userHospitalDetails.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'DisplaySurgery.dart';
import 'SearchPage.dart';
import 'models/HomePageModel.dart';

class HomePage extends StatefulWidget {
  final String firstname;

  const HomePage({super.key, required this.firstname});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Query dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospital');
  late String data;
  final key = 'username';
  late String userKey;
  final _messagingService = MessagingService();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _messagingService.init(context);
    _loadUserData();
  }
  Future<void> _loadUserData() async {
    String? userkey = await getKey();
    String? userData = await getData(key);
    setState(() {
      data = userData!;
      userKey = userkey!;
    });
    var fcmToken = await _fcm.getToken();
    final updatedData = {
      "UserFCMToken": fcmToken,
    };
    final userRef = FirebaseDatabase.instance
        .ref()
        .child("ArogyaSair/tblUser")
        .child(userKey);
    await userRef.update(updatedData);
  }

  var imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2Faiims.jpeg?alt=media";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth * 1,
          height: constraints.maxHeight * 1,
          child: Scaffold(
            backgroundColor: const Color(0xfff2f6f7),
            appBar: AppBar(
              backgroundColor: const Color(0xfff2f6f7),
              automaticallyImplyLeading: false,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Welcome to",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 12, color: Color(0xffabafb0))),
                  Text(widget.firstname,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold))
                ],
              ),
              iconTheme: const IconThemeData(
                color: Color(0xff12d3c6),
              ),
            ),
            endDrawer: const DrawerCode(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Container(
                      width: 400,
                      height: constraints.maxHeight * 0.10,
                      decoration: const BoxDecoration(
                        color: Color(0xfff2f6f7),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                        child: Container(
                          width: double.infinity - 10,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 8, 0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchPage()));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 4, 0),
                                    child: Icon(
                                      Icons.search_rounded,
                                      color: Colors.black,
                                      size: 22,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SearchPage(),
                                          ),
                                        );
                                      },
                                      child: const SelectionArea(
                                        child: Text(
                                          "Search...",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Manrope',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DisplayHospitals(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: SizedBox(
                                width: 200,
                                height: constraints.maxHeight * 0.10,
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // Adjust the radius as needed
                                            child: Image.asset(
                                              'assets/Animation/generalcheckup.jpg',
                                              width: 100,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 0),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 18.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.right,
                                                  "Request for",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  textAlign: TextAlign.right,
                                                  'Check-Up',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DisplaySurgery(),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: SizedBox(
                                width: 200,
                                height: constraints.maxHeight * 0.10,
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // Adjust the radius as needed
                                            child: Image.asset(
                                              'assets/Animation/surgery.jpg',
                                              width: 100,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 0),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 18.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Request for",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  'Surgery',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        color: Color(0xff12d3c6),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: get_home_data(),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(color: Color(0xff12d3c6)),
                    child: StreamBuilder(
                      stream: dbRef2.onValue,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data!.snapshot.value != null) {
                          Map<dynamic, dynamic> map =
                              snapshot.data!.snapshot.value;
                          List<HomeData> packagesList = [];
                          packagesList.clear();
                          map.forEach((key, value) {
                            packagesList.add(HomeData.fromMap(value, key));
                          });
                          return GridView.builder(
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: constraints.maxHeight * 0.00145,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: packagesList.length,
                            padding: const EdgeInsets.all(0),
                            itemBuilder: (BuildContext context, int index) {
                              if (packagesList[index].hospitalImage == "") {
                                imagePath =
                                    "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2FArogyaSair.png?alt=media";
                              } else {
                                imagePath =
                                    "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2F${packagesList[index].hospitalImage}?alt=media";
                              }
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: FillImageCard(
                                      imageProvider: NetworkImage(
                                        imagePath,
                                      ),
                                      heightImage:
                                          MediaQuery.of(context).size.height *
                                              0.23,
                                      title: Text(
                                          packagesList[index].hospitalName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      height: double.infinity,
                                      width: double.infinity,
                                      description: Text(
                                          packagesList[index].hospitalEmail),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HospitalDetails(
                                            hospitalKey: packagesList[index]
                                                .hospitalEmail),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
