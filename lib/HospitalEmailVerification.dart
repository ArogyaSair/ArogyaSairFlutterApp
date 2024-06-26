// ignore_for_file: use_build_context_synchronously, file_names, prefer_typing_uninitialized_variables

import 'package:arogyasair/HospitalLogin.dart';
import 'package:arogyasair/HospitalRegistration.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HospitalEmailVerification extends StatefulWidget {
  const HospitalEmailVerification({super.key});

  @override
  State<HospitalEmailVerification> createState() => _HospitalRegisterState();
}

class _HospitalRegisterState extends State<HospitalEmailVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var key1 = 'email';
  var data;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerOTP = TextEditingController();
  EmailOTP myauth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Center(
                child: Image.asset(
                  'assets/Logo/ArogyaSair.png',
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: controllerEmail, // enabled: false,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.mail, color: Color(0xff12d3c6)),
                  suffixIcon: TextButton(
                    onPressed: () async {
                      Query dbRef2 = FirebaseDatabase.instance
                          .ref()
                          .child('ArogyaSair/tblHospital')
                          .orderByChild("Email")
                          .equalTo(controllerEmail.text);
                      await dbRef2.once().then((documentSnapshot) async {
                        for (var x in documentSnapshot.snapshot.children) {
                          data = x.value as Map;
                        }
                        if (data == null) {
                          myauth.setConfig(
                            appEmail: "arogyasair@gmail.com",
                            appName: "Arogya Sair",
                            userEmail: controllerEmail.text,
                            otpLength: 6,
                            otpType: OTPType.digitsOnly,
                          );
                          myauth.setTheme(theme: "v2");
                          if (await myauth.sendOTP() == true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("OTP has been sent"),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Oops, OTP send failed"),
                            ));
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "This Email is already registered with us. Please try to login..!"),
                          ));
                        }
                      });
                    },
                    child: const Text("Send OTP",
                        style: TextStyle(color: Color(0xff12d3c6))),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: controllerOTP,
                decoration: const InputDecoration(
                  hintText: "OTP",
                  labelText: "Enter OTP",
                  prefixIcon: Icon(Icons.password, color: Color(0xff12d3c6)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  elevation: 10,
                  backgroundColor: const Color(0xff12d3c6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  if (await myauth.verifyOTP(otp: controllerOTP.text) == true) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HospitalRegistration(
                          Email: controllerEmail.text,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Invalid OTP"),
                      ),
                    );
                  }
                },
                child: const Text("Verify OTP",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "Already registered..?",
                    style: TextStyle(color: Colors.black, fontSize: 16),
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
                            builder: (context) => const HospitalLogin()),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Color(0xff12d3c6),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
