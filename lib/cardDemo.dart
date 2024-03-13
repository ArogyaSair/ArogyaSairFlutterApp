// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

import 'SearchPage.dart';

void main() {
  runApp(const MaterialApp(
    home: cardDemo(),
  ));
}

class cardDemo extends StatefulWidget {
  const cardDemo({super.key});

  @override
  State<cardDemo> createState() => _cardDemoState();
}

class _cardDemoState extends State<cardDemo> {
  var imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/UserImage%2FDefaultProfileImage.png?alt=media";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Card"),
      ),
      body: Column(children: [
        // Generated code for this Container Widget...
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
          child: Container(
            width: double.infinity,
            height: 63,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
              child: Container(
                width: double.infinity,
                height: 0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.blue,
                      offset: Offset(0, 2),
                      spreadRadius: 2,
                    )
                  ],
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchPage()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                          child: Icon(
                            Icons.search_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchPage()));
                            },
                            child: const SelectionArea(
                              child: Text(
                                "Search...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Manrope',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                for (var i = 0; i < 17; i++)
                  Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4ECF7),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Image.network(imagePath),
                  ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

//
// FirebaseAnimatedList(
//   query: dbRef2,
//   itemBuilder: (BuildContext context, DataSnapshot snapshot,
//       Animation<double> animation, int index) {
//     Map data1 = snapshot.value as Map;
//     var imageName = "HospitalImage%2F${data1['Photo']}";
//     var imagePath =
//         "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/$imageName?alt=media";
//     return ;
//   },
// )
// Flexible(
//   child: FirebaseAnimatedList(
//     query: dbRef2,
//     itemBuilder: (BuildContext context, DataSnapshot snapshot,
//         Animation<double> animation, int index) {
//       Map data1 = snapshot.value as Map;
//       var imageName = "HospitalImage%2F${data1['Photo']}";
//       var imagePath =
//           "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/$imageName?alt=media";
//       return ListTile(
//         contentPadding: EdgeInsets.all(1),
//         leading: Image.network(
//           imagePath,
//           height: 500,
//           width: 150,
//         ),
//         title: Text(data1['HospitalName'].toString()),
//         subtitle: Text(data1['HospitalCity'].toString()),
//       );
//     },
//   ),
// )
