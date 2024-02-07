// ignore_for_file: use_build_context_synchronously, file_names, camel_case_types

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'SplashScreen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: Splash()));
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  splash createState() => splash();
}

class splash extends State<Splash> {
  @override
  void initState() {
    super.initState();
    {
      navigateToHome();
    }
  }

  navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/Logo/ArogyaSair.gif")],
        ),
      ),
    );
  }
}
