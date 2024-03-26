// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:arogyasair/DisplayHospitals.dart';
import 'package:arogyasair/drawerSideNavigation.dart';
import 'package:arogyasair/firebase_api.dart';
import 'package:arogyasair/get_home_data.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:arogyasair/userHospitalDetails.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'DisplaySurgery.dart';
import 'SearchPage.dart';
import 'models/HomePageModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
            appBar: AppBar(
              backgroundColor: Colors.blue.shade900,
              automaticallyImplyLeading: false,
              title: const Text(
                'Arogya Sair',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            endDrawer: const DrawerCode(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Container(
                      width: double.infinity,
                      height: constraints.maxHeight * 0.07,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                        child: Container(
                          width: double.infinity,
                          height: 0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade800,
                                Colors.blue.shade700,
                                Colors.teal.shade400,
                                Colors.teal.shade300,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.centerRight,
                            ),
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
                                      color: Colors.white,
                                      size: 24,
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
                                            color: Colors.white,
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
                  const get_home_data(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DisplaySurgery(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.all(16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade800,
                              Colors.blue.shade700,
                              Colors.teal.shade400,
                              Colors.teal.shade300,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: constraints.maxHeight * 0.15,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Lottie.asset(
                                    'assets/Animation/surgery.json',
                                    width: 180,
                                    height: 120,
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 55),
                                  child: Center(
                                    child: Text(
                                      'Request For Surgery',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
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
                  GestureDetector(
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
                      margin: const EdgeInsets.all(16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade800,
                              Colors.blue.shade700,
                              Colors.teal.shade400,
                              Colors.teal.shade300,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: constraints.maxHeight * 0.15,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Lottie.asset(
                                    'assets/Animation/treatment.json',
                                    width: 180,
                                    height: 120,
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 55),
                                  child: Center(
                                    child: Text(
                                      'Request For Check up',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
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
                  StreamBuilder(
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
                            crossAxisCount: 2,
                            childAspectRatio: constraints.maxHeight * 0.00089,
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
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  margin: const EdgeInsets.all(16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue.shade800,
                                          Colors.blue.shade700,
                                          Colors.teal.shade400,
                                          Colors.teal.shade300,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image.network(
                                                  imagePath,
                                                  height:
                                                      constraints.maxHeight *
                                                          0.1,
                                                  width: constraints.maxHeight *
                                                      0.2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5, top: 5),
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Text(
                                                        packagesList[index]
                                                            .hospitalName,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Text(
                                                        packagesList[index]
                                                            .hospitalEmail,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Text(
                                                        "${packagesList[index].hospitalCity}, ${packagesList[index].hospitalState}",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
                ],
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () async {
            //     notificationServices.getDeviceToken().then((value) async {
            //       var data = {
            //         'to': value.toString(),
            //         'priority': 'high',
            //         'notification': {
            //           'title': "Arogya Sair",
            //           'body': 'Hello from admin',
            //         }
            //       };
            //       await http.post(
            //         Uri.parse('https://fcm.googleapis.com/fcm/send'),
            //         body: jsonEncode(data),
            //         headers: {
            //           'Content-type': 'application/json; charset=UTF-8',
            //           'Authorization':
            //               'key=AAAANZSWEE8:APA91bGT4zt_EFbTd_zsH9VQf0ydv7wTmKR9pGgdN0r509WHczxR2uwMj4bk9UajZvOix_l3y6a6usEnXZMWyA3q04W7n49K92zK45fbqwXsRm5NL_Ryru5MlqSexZ7exPNK820TyH1C'
            //         },
            //       );
            //     });
            //   },
            // ),
          ),
        );
      },
    );
  }
}
