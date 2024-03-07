// ignore_for_file: file_names
// // ignore_for_file: file_names
//
// import 'package:arogyasair/BottomNavigation.dart';
// import 'package:arogyasair/EditProfile.dart';
// import 'package:arogyasair/drawerSideNavigation.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     home: MyProfile1(),
//   ));
// }
//
// class MyProfile1 extends StatefulWidget {
//   const MyProfile1({Key? key}) : super(key: key);
//
//   @override
//   State<MyProfile1> createState() => _MyProfile1State();
// }
//
// class _MyProfile1State extends State<MyProfile1> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Arogya Sair"),
//       ),
//       bottomNavigationBar: const bottomBar(),
//       endDrawer: const DrawerCode(),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(10, 2, 2, 2),
//             child: Text("Username"),
//           ),
//           const Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(10, 2, 2, 2),
//             child: Text("Email"),
//           ),
//           Padding(
//             padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
//             child: InkWell(
//               onTap: () async {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const EditProfile()));
//               },
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(16, 20, 0, 20),
//                       child: Text("Edit Profile"),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 20),
//                     child: Icon(Icons.arrow_forward_ios),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
//             child: InkWell(
//               onTap: () async {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const EditProfile()));
//               },
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(16, 20, 0, 20),
//                       child: Text("Change Password"),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 20),
//                     child: Icon(Icons.arrow_forward_ios),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
