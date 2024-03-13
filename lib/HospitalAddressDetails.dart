// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'package:arogyasair/HospitalServices.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'HospitalLogin.dart';

class HospitalAddressDetails extends StatefulWidget {
  final String Email;
  final String Name;

  const HospitalAddressDetails(
      {super.key, required this.Email, required this.Name});

  @override
  State<HospitalAddressDetails> createState() => _HospitalAddressDetailsState();
}

class _HospitalAddressDetailsState extends State<HospitalAddressDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? Key;

  Future<void> loadData() async {
    Query dbRef = FirebaseDatabase.instance
        .ref()
        .child("ArogyaSair/tblHospital")
        .orderByChild("HospitalName")
        .equalTo(widget.Name);
    Map data;
    await dbRef.once().then((documentSnapshot) async {
      for (var x in documentSnapshot.snapshot.children) {
        Key = x.key;
        data = x.value as Map;
        await saveData("HospitalName", data["HospitalName"]);
        await saveData("HospitalEmail", data["Email"]);
        await saveKey(Key);
      }
    });
  }

  DatabaseReference dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospital');

  TextEditingController controlleruname = TextEditingController();
  TextEditingController controllername = TextEditingController();
  TextEditingController controllermail = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerState = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    controllermail = TextEditingController(text: widget.Email);
    controllername = TextEditingController(text: widget.Name);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Logo Image
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Center(
                child: Image.asset(
                  'assets/Logo/ArogyaSair.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ), // Full Name
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controllername,
                      enabled: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Full Name',
                        hintText: 'Enter Name',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllermail,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      enabled: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Email',
                        hintText: 'Enter Email',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.streetAddress,
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.pin_drop),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Address',
                        hintText: 'Enter Address',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerCity,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter City';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.streetAddress,
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.pin_drop),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'City',
                        hintText: 'Enter City',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerState,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter State';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.streetAddress,
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.pin_drop),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'State',
                        hintText: 'Enter State',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var address = controllerAddress.text;
                        var city = controllerCity.text;
                        var state = controllerState.text;
                        var email = controllermail.text;
                        var name = controllername.text;
                        final updateData = {
                          "HospitalAddress": address,
                          "HospitalCity": city,
                          "HospitalState": state,
                          "HospitalName": name,
                          "Email": email,
                        };

                        final hospitalRef = FirebaseDatabase.instance
                            .ref()
                            .child("ArogyaSair/tblHospital")
                            .child(Key!);
                        await hospitalRef.update(updateData);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HospitalServices()));
                      },
                      child: const Text("Add Details"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "Already have an account..?",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HospitalLogin()),
                              );
                            },
                            child: const Text(
                              "Login here",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
