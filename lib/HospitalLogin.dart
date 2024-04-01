// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:arogyasair/HospitalPasswordChangeUserName.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';

import 'HospitalEmailVerification.dart';
import 'HospitalFirstPasswordChange.dart';
import 'HospitalHomePage.dart';

class HospitalLogin extends StatefulWidget {
  const HospitalLogin({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<HospitalLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController controlleremail = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 16.0),
      child: Scaffold(
        key: _formKey,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff12d3c6), Color(0xff12d3c6)])),
              child: const Padding(
                padding: EdgeInsets.only(top: 60, left: 22),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
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
                    padding:
                        const EdgeInsets.only(top: 50, right: 20, left: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: controlleremail,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter Email';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email_outlined,
                                            color: Color(0xff12d3c6)),
                                        prefixIconColor: Colors.blue,

                                        labelText: 'Email',
                                        filled: false,
                                        // fillColor: Color(0xffE0E3E7),
                                        hintText: 'Enter Email',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: controllerpassword,
                                      obscureText: !isPasswordVisible,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter password';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.lock,
                                            color: Color(0xff12d3c6)),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            isPasswordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: const Color(0xff12d3c6),
                                          ),
                                          onPressed: () {
                                            _togglePasswordVisibility(context);
                                          },
                                        ),
                                        prefixIconColor: Colors.blue,

                                        filled: false,
                                        // fillColor: const Color(0xffE0E3E7),
                                        labelText: 'Password',
                                        hintText: 'Enter Password',
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HospitalPasswordChangeUserName()));
                                          },
                                          child: Text("Forgot Password ?",
                                              style: TextStyle(
                                                  color: Colors.grey.shade700)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 300,
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xff12d3c6),
                                            Color(0xff12d3c6)
                                          ]),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _performLogin(context);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                        ),
                                        child: const Text(
                                          'LOG IN',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Text(
                                            "Don't registered..?",
                                            style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 16),
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
                                                        const HospitalEmailVerification()),
                                              );
                                            },
                                            child: const Text(
                                              "Register",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(0xff12d3c6),
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
        // body: SingleChildScrollView(
        //   // ),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _togglePasswordVisibility(BuildContext context) {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void _performLogin(BuildContext context) async {
    final scaffoldContext = context;

    var email = controlleremail.text;
    var password = controllerpassword.text;
    var encPassword = encryptString(password);
    Query dbRef2 = FirebaseDatabase.instance
        .ref()
        .child('ArogyaSair/tblHospital')
        .orderByChild("Email")
        .equalTo(email);
    String msg = "Invalid Username or Password..! Please check..!!";
    Map data;
    var count = 0;
    await dbRef2.once().then((documentSnapshot) async {
      for (var x in documentSnapshot.snapshot.children) {
        String? key = x.key;
        data = x.value as Map;
        if (data["Email"] == email &&
            data["Password"].toString() == password.toString()) {
          await saveData('HospitalEmail', data["Email"]);
          await saveData('HospitalName', data["HospitalName"]);
          await saveData('key', key);
          count = count + 1;
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HospitalFirstChangePassword()));
        } else if (data["Email"] == email &&
            data["Password"].toString() == encPassword) {
          await saveData('HospitalEmail', data["Email"]);
          await saveData('HospitalName', data["HospitalName"]);
          await saveData('key', key);
          count = count + 1;
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HospitalHomePage(0)));
        } else {
          msg = "Sorry..! Wrong Username or Password";
          _showSnackbar(scaffoldContext, msg);
        }
      }
      if (count == 0) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Alert Message"),
              content: Text(msg.toString()),
              actions: <Widget>[
                OutlinedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
      }
    });
  }
}

String encryptString(String originalString) {
  var bytes = utf8.encode(originalString); // Convert string to bytes
  var digest = sha256.convert(bytes); // Apply SHA-256 hash function
  return digest.toString(); // Return the hashed string
}
