// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:arogyasair/HospitalEmailVerification.dart';
import 'package:arogyasair/HospitalHomePage.dart';
import 'package:arogyasair/saveSharePreferences.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'HospitalFirstPasswordChange.dart';

class HospitalLogin extends StatefulWidget {
  const HospitalLogin({Key? key}) : super(key: key);

  @override
  _HospitalLoginState createState() => _HospitalLoginState();
}

class _HospitalLoginState extends State<HospitalLogin> {
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(1),
                child: Center(
                  child: Image.asset(
                    'assets/Logo/ArogyaSair.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
                            prefixIcon: Icon(Icons.email_outlined),
                            prefixIconColor: Colors.blue,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            labelText: 'Email',
                            filled: true,
                            fillColor: Color(0xffE0E3E7),
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
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            filled: true,
                            fillColor: const Color(0xffE0E3E7),
                            labelText: 'Password',
                            hintText: 'Enter Password',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _performLogin(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(200, 50),
                              elevation: 10,
                              backgroundColor: Colors.blue),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                "Don't registered..?",
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
                                        builder: (context) =>
                                            const HospitalEmailVerification()),
                                  );
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.blue,
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
              ),
            ],
          ),
        ),
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
          print("asdfg is ${data["Email"]}");

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
          print("key is  $key");
          // print("shared key is ${getKey()}");
          count = count + 1;
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HospitalHomePage()));
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
