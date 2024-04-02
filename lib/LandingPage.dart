// ignore_for_file: non_constant_identifier_names, camel_case_types, library_private_types_in_public_api, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'HospitalLogin.dart';
import 'Login.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String data = "";
  final key = 'username';
  final key1 = 'HospitalEmail';
  late bool containsKey;
  late bool containsKey1;
  late String KeyToCheck;

  var logger = Logger();

  // @override
  // void initState() {
  //   super.initState();
  //   _checkIfLoggedIn();
  // }

  // Future<void> _checkIfLoggedIn() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   containsKey = prefs.containsKey(key);
  //   containsKey1 = prefs.containsKey(key1);
  //   KeyToCheck = (await getKey())!;
  //   DatabaseReference dbUserRef =
  //       FirebaseDatabase.instance.ref().child("ArogyaSair/tblUser/$KeyToCheck");
  //
  //   DatabaseEvent databaseEvent = await dbUserRef.once();
  //   DataSnapshot dataSnapshot = databaseEvent.snapshot;
  //
  //   DatabaseReference dbHospitalRef = FirebaseDatabase.instance
  //       .ref()
  //       .child("ArogyaSair/tblHospital/$KeyToCheck");
  //
  //   DatabaseEvent databaseEventHospital = await dbHospitalRef.once();
  //   DataSnapshot dataSnapshotHospital = databaseEventHospital.snapshot;
  //
  //   if (dataSnapshot.value != null || dataSnapshotHospital.value != null) {
  //     logger.d("Has Data");
  //     if (containsKey) {
  //       Navigator.pop(context);
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => const HomePage()));
  //     }
  //     if (containsKey1) {
  //       Navigator.pop(context);
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => const HospitalHomePage(0)));
  //     }
  //   } else {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.clear();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SizedBox(
        width: constraints.maxWidth * 1,
        height: constraints.maxHeight * 1,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Image.asset(
                    "assets/Logo/ArogyaSair.png",
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Image.asset(
                    "assets/Animation/hospital.jpg",
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 80.0,
                      ),
                      child: Text(
                        "Arogya Sair",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xff12d3c6),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.35,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50)),
                            color: Colors.transparent),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  bottom: 20.0, top: 10, right: 210),
                              child: Text(
                                "Login As",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff12d3c6),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(250, 50),
                                  elevation: 10,
                                  backgroundColor: const Color(0xff12d3c6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: const Text(
                                  "User",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HospitalLogin()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(250, 50),
                                  elevation: 10,
                                  backgroundColor: const Color(0xff12d3c6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: const Text(
                                  "Hospital",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Padding(
                //   padding: const EdgeInsets.all(1),
                //   child: TextButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const HospitalLandingPage()),
                //       );
                //     },
                //     child: const Text(
                //       "For Hospital",
                //       style: TextStyle(
                //           fontSize: 15,
                //           color: Colors.blue,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
