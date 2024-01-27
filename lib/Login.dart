import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Registration.dart';

// void main() {
//   runApp(const MaterialApp(home: Login()));
// }

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controlleruname = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
            child: TextFormField(
              controller: controlleruname,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                prefixIconColor: Colors.blue,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                labelText: 'Username',
                filled: true,
                fillColor: Color(0xffE0E3E7),
                hintText: 'Enter Username',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: controllerpassword,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () async {
                _performLogin(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                elevation: 10,
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "Don't have account yet..?",
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
                        MaterialPageRoute(builder: (context) => Registration()),
                      );
                    },
                    child: const Text(
                      "Register here",
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
    // Use a local variable to capture the context
    final scaffoldContext = context;

    var username = controlleruname.text;
    var password = controllerpassword.text;
    Query dbRef2 = FirebaseDatabase.instance
        .ref()
        .child('DemoDB/Employee')
        .orderByChild("Username")
        .equalTo(username);
    String msg = "";
    Map data2;
    await dbRef2.once().then((documentSnapshot) {
      for (var x in documentSnapshot.snapshot.children) {
        data2 = x.value as Map;
        if (data2["Username"] == username &&
            data2["Password"].toString() == password.toString()) {
          msg = "Login successful";
        } else {
          msg = "Sorry..! Wrong Username or Password";
        }
      }

      // Show a Snackbar using the captured context
      _showSnackbar(scaffoldContext, msg);
    });
  }
}
