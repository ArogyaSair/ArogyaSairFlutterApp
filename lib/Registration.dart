// ignore_for_file: file_names, non_constant_identifier_names, library_private_types_in_public_api

import 'dart:convert';

import 'package:arogyasair/Login.dart';
import 'package:arogyasair/models/RegisterModel.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _Registration createState() => _Registration();
}

class _Registration extends State<Registration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DatabaseReference dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblUser');

  TextEditingController controlleruname = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();
  TextEditingController controllerconfirmpassword = TextEditingController();
  TextEditingController controllername = TextEditingController();
  TextEditingController controllermail = TextEditingController();
  TextEditingController controllcontact = TextEditingController();
  TextEditingController controllerDateOfBirth = TextEditingController();
  var birthDate = "Select Birthdate";
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    controllerDateOfBirth = TextEditingController(text: birthDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF0D47A1), Colors.lightBlue])),
          child: const Padding(
            padding: EdgeInsets.only(top: 60, left: 22),
            child: Text(
              "Register",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Form(
            key: _formKey,
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.maxFinite,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 150, right: 20, left: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controllername,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            prefixIconColor: Colors.blue,
                            prefixIcon: Icon(Icons.person),
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
                          controller: controlleruname,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            prefixIconColor: Colors.blue,
                            prefixIcon: Icon(Icons.account_box),
                            labelText: 'Username',
                            hintText: 'Enter Username',
                            filled: true,
                            fillColor: Color(0xffE0E3E7),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: controllerpassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                _togglePasswordVisibility(context);
                              },
                            ),
                            prefixIconColor: Colors.blue,
                            labelText: 'Password',
                            hintText: 'Enter Password',
                            filled: true,
                            fillColor: const Color(0xffE0E3E7),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: controllerconfirmpassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter re-enter password';
                            }
                            return null;
                          },
                          obscureText: !isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                _toggleConfirmPasswordVisibility(context);
                              },
                            ),
                            prefixIconColor: Colors.blue,
                            labelText: 'Confirm Password',
                            hintText: 'Re-Enter Password',
                            filled: true,
                            fillColor: const Color(0xffE0E3E7),
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
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            prefixIconColor: Colors.blue,
                            prefixIcon: Icon(Icons.email),
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
                          controller: controllcontact,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Contact number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixIconColor: Colors.blue,
                            prefixIcon: Icon(Icons.call),
                            labelText: 'Contact Number',
                            hintText: 'Enter Contact',
                            filled: true,
                            fillColor: Color(0xffE0E3E7),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: controllerDateOfBirth,
                          readOnly: true,
                          // Make the text input read-only
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffE0E3E7),
                            prefixIcon: GestureDetector(
                              onTap: () {
                                _getDate(context);
                              },
                              child: const Icon(
                                Icons.date_range,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              var name = controllername.text;
                              var password = controllerpassword.text;
                              var confirmPassword =
                                  controllerconfirmpassword.text;
                              var username = controlleruname.text;
                              var email = controllermail.text;
                              var contact = controllcontact.text;
                              var DOB = birthDate;
                              var encPassword = encryptString(password);
                              if (password == confirmPassword) {
                                RegisterModel regobj = RegisterModel(username,
                                    encPassword, email, name, DOB, contact);
                                dbRef2.push().set(regobj.toJson());
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                              } else {
                                const snackBar = SnackBar(
                                  content: Text("Password does not match..!!"),
                                  duration: Duration(seconds: 2),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          },
                          child: const Text("Sign up"),
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
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
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
                                        builder: (context) => const Login()),
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
                )),
          ),
        ),
      ]),
    );
  }

  void _togglePasswordVisibility(BuildContext context) {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  Future<void> _getDate(BuildContext context) async {
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2090),
      dateFormat: "dd-MM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );
    setState(() {
      if (datePicked != null) {
        birthDate = "${datePicked.day}-${datePicked.month}-${datePicked.year}";
        controllerDateOfBirth = TextEditingController(text: birthDate);
      }
    });
  }

  void _toggleConfirmPasswordVisibility(BuildContext context) {
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }
}

String encryptString(String originalString) {
  var bytes = utf8.encode(originalString); // Convert string to bytes
  var digest = sha256.convert(bytes); // Apply SHA-256 hash function
  return digest.toString(); // Return the hashed string
}
