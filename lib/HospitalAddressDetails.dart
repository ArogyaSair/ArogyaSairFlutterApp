import 'dart:convert';

// import 'package:arogyasair/HospitalHomePage.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'HospitalLogin.dart';
// import 'models/HospitalRegisterModel.dart';

class HospitalAddressDetails extends StatefulWidget {
  final String Email;
  final String Name;

  const HospitalAddressDetails(
      {Key? key, required this.Email, required this.Name})
      : super(key: key);

  @override
  State<HospitalAddressDetails> createState() => _HospitalAddressDetailsState();
}

class _HospitalAddressDetailsState extends State<HospitalAddressDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var address = controllerAddress.text;
                          var city = controllerCity.text;
                          var state = controllerState.text;
                          var email = controllermail.text;
                          var name = controllername.text;

                          print(address);
                          print(city);
                          print(state);
                          print(email);
                          print(name);

                          // var name = controllername.text;
                          // var email = controllermail.text;
                          // if (password == confirmPassword) {
                          //   HospitalRegisterModel regobj =
                          //   HospitalRegisterModel(encPassword, email,
                          //       name, "", "", "", "", "", "", "");
                          //   dbRef2.push().set(regobj.toJson());
                          //   Navigator.of(context).pop();
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //           const HospitalHomePage()));
                          // } else {
                          //   const snackBar = SnackBar(
                          //     content: Text("Password does not match..!!"),
                          //     duration: Duration(seconds: 2),
                          //   );
                          //   ScaffoldMessenger.of(context)
                          //       .showSnackBar(snackBar);
                          // }
                        }
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
// void _toggleConfirmPasswordVisibility(BuildContext context) {
//   setState(() {
//     isConfirmPasswordVisible = !isConfirmPasswordVisible;
//   });
// }
//
// void _togglePasswordVisibility(BuildContext context) {
//   setState(() {
//     isPasswordVisible = !isPasswordVisible;
//   });
// }
}

String encryptString(String originalString) {
  var bytes = utf8.encode(originalString); // Convert string to bytes
  var digest = sha256.convert(bytes); // Apply SHA-256 hash function
  return digest.toString(); // Return the hashed string
}
