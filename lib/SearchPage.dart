// ignore_for_file: file_names

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Query dbRef;
  TextEditingController searchController = TextEditingController();
  late StreamController<List<Map>> _streamController;
  String searchValue = '';

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Map>>();
    dbRef = FirebaseDatabase.instance.ref().child('ArogyaSair/tblHospital');
    _updateList('');
  }

  void _updateList(String query) {
    // Convert the query to lowercase for case-insensitive search
    String lowercaseQuery = query.toLowerCase();

    dbRef.orderByChild("HospitalName").onValue.listen((event) {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      List<Map> hospitals = [];
      if (values != null) {
        values.forEach((key, value) {
          // Convert the HospitalName to lowercase for case-insensitive comparison
          String hospitalNameLowerCase =
              (value['HospitalName'] as String?)?.toLowerCase() ?? '';

          // Check if the lowercase version of HospitalName contains the lowercase query
          if (hospitalNameLowerCase.contains(lowercaseQuery)) {
            hospitals.add(Map.from(value));
          }
        });
      }
      _streamController.add(hospitals);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CupertinoSearchTextField(
          controller: searchController,
          autofocus: true,
          onSubmitted: (String value) {
            setState(() {
              searchValue = value;
              _updateList(searchValue);
            });
          },
          autocorrect: true,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<List<Map>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map>? hospitals = snapshot.data;
            return ListView.builder(
              itemCount: hospitals?.length ?? 0,
              itemBuilder: (context, index) {
                Map data1 = hospitals![index];
                var imageName = "HospitalImage%2F${data1['Photo']}";
                var imagePath =
                    "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/$imageName?alt=media";
                return ListTile(
                  contentPadding: const EdgeInsets.all(1),
                  leading: Image.network(imagePath),
                  title: Text(data1['HospitalName'].toString()),
                  subtitle: Text(data1['HospitalCity'].toString()),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
