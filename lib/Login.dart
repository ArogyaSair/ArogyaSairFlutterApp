import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Login()));
}

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
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
                prefixIconColor: Colors.blue,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: 'Password',
                hintText: 'Enter Password',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () async {
                var username = controlleruname.text;
                var password = controllerpassword.text;
                Query dbRef2 = FirebaseDatabase.instance
                    .ref()
                    .child('DemoDB/Employee')
                    .orderByChild("Username")
                    .equalTo(username);
                var msg;
                Map data2;
                await dbRef2.once().then((DocumentSnapshot) => {
                  for (var x in DocumentSnapshot.snapshot.children)
                    {
                      data2 = x.value as Map,
                      if (data2["Username"] == username && data2["Password"].toString() == password.toString())
                        {msg = "Welcome"}
                      else
                        {msg = "Sorry"}
                    }
                });
                final snackBar = SnackBar(
                  content: Text(msg),
                  duration: const Duration(seconds: 2), // You can customize the duration
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
          )
        ],
      ),
    );
  }
}