// ignore_for_file: file_names, non_constant_identifier_names, library_private_types_in_public_api

import 'package:arogyasair/Login.dart';
import 'package:arogyasair/models/RegisterModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';

void main(){
  runApp(const MaterialApp(home: Registration(),));
}

class Registration extends StatefulWidget {
  const Registration({super.key});
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
      key: _formKey,
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
            ),
            // Full Name
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Form(
                key: _formKey,
                child: TextFormField(
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
              ),
            ),
            // Username
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: TextFormField(
                controller: controlleruname,
                decoration: const InputDecoration(
                  prefixIconColor: Colors.blue,
                  prefixIcon: Icon(Icons.account_box),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Username',
                  hintText: 'Enter Username',
                  filled: true,
                  fillColor: Color(0xffE0E3E7),
                ),
              ),
            ),
            // Password
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: TextFormField(
                controller: controllerpassword,
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
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  filled: true,
                  fillColor: const Color(0xffE0E3E7),
                  labelText: 'Password',
                  hintText: 'Enter Password',
                ),
              ),
            ),
            // Confirm Password
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: TextFormField(
                controller: controllerconfirmpassword,
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
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  filled: true,
                  fillColor: const Color(0xffE0E3E7),
                  labelText: 'Confirm Password',
                  hintText: 'Re-Enter Password',
                ),
              ),
            ),
            // Email
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: TextFormField(
                controller: controllermail,
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: TextFormField(
                controller: controllerDateOfBirth,
                decoration: InputDecoration(
                  prefixIconColor: Colors.blue,
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.date_range),
                    onPressed: () {
                      _getDate(context);
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: "Select Birthdate",
                  filled: true,
                  fillColor: const Color(0xffE0E3E7),
                ),
              ),
            ),

            // Sign up button
            Padding(
              padding: const EdgeInsets.only(top: 1, left: 10, right: 10),
              child: ElevatedButton(
                onPressed: () {
                  var name = controllername.text;
                  var password = controllerpassword.text;
                  var confirmPassword = controllerconfirmpassword.text;
                  var username = controlleruname.text;
                  var email = controllermail.text;
                  var DOB = birthDate;

                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, submit it
                    // _errorMessage = ""; // clear error message if any
                    // Here you can do something with the validated text
                    // print('Valid text: ${controllername.text}');
                  } else {
                    setState(() {
                      // Set error message if validation fails
                      // _errorMessage = 'Please correct the errors above';
                    });
                  }

                  if (name.isNotEmpty &&
                      password.isNotEmpty &&
                      confirmPassword.isNotEmpty &&
                      username.isNotEmpty &&
                      email.isNotEmpty &&
                      DOB != "Select Birthdate") {
                    if (password == confirmPassword) {
                      RegisterModel regobj =
                      RegisterModel(username, password, email, name, DOB);
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
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    const snackBar = SnackBar(
                      content:
                      Text("Please enter all the details properly..!!"),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text("Sign up"),
              ),
            ),
            // Login link
            Padding(
              padding: const EdgeInsets.all(1),
              child: Row(
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
            )
          ],
        ),
      ),
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
