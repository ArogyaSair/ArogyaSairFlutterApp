// ignore_for_file: file_names
// // ignore_for_file: file_names, unused_field
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:multi_dropdown/multiselect_dropdown.dart';
//
// import 'firebase_options.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Flutter Demo',
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class User {
//   final String name;
//
//   User({required this.name});
//
//   @override
//   String toString() {
//     return 'User(name: $name)';
//   }
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final MultiSelectController<User> _controller = MultiSelectController();
//
//   Future<List<User>> _fetchUsers() async {
//     final ref = FirebaseDatabase.instance.ref('ArogyaSair/tblDoctor');
//
//     try {
//       DataSnapshot snapshot = (await ref.once()) as DataSnapshot;
//
//       if (snapshot.value != null) {
//         Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
//         return data.entries.map((entry) {
//           return User(name: entry.value['DoctorName']);
//         }).toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       print('Error fetching users: $e');
//       return [];
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: FutureBuilder<List<User>>(
//       future: _fetchUsers(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator(); // or any other loading indicator
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (snapshot.hasData) {
//           final users = snapshot.data!;
//           return Scaffold(
//             body: MultiSelectDropDown<User>(
//               options: users.map((user) => ValueItem(label: user.name, value: user)).toList(),
//               onOptionSelected: (List<ValueItem<User>> selectedOptions) {
//                 // handle selected options
//               },
//             ),
//           );
//         } else {
//           return const Text('No data available'); // or any other message
//         }
//       },
//     ));
//   }
// }
