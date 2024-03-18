import 'package:arogyasair/saveSharePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyPackages extends StatefulWidget {
  const MyPackages({super.key});

  @override
  State<MyPackages> createState() => _MyPackagesState();
}

class _MyPackagesState extends State<MyPackages> {
  late String imagePath;
  late String userId;
  List<Map> packages = [];
  late String packageImagePath;
  Map<dynamic, dynamic>? userData;
  bool dataFetched = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? userData = await getKey();
    setState(() {
      userId = userData!;
    });
  }

  Future<List<Map>> getPackagesData() async {
    if (dataFetched) {
      return packages;
    }
    DatabaseReference dbRef =
        FirebaseDatabase.instance.ref().child('ArogyaSair/tblBookedPackages');
    DatabaseEvent event =
        await dbRef.orderByChild("UserName").equalTo(userId).once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value == null) {
      return packages;
    }

    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

    values.forEach((key, value) async {
      packages.add({
        'Key': key,
        'DateOfStarting': value['Date_of_starting'],
        'Duration': value["Duration"],
        'HospitalName': value["HospitalName"],
        'Include': value["Include"],
        'UserId': value["UserName"],
        'PackageName': value["PackageName"],
      });
      dataFetched = true;
    });
    return packages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map>>(
        future: getPackagesData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            if (packages.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  packages[index]["PackageName"],
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "${packages[index]["Duration"]} weeks",
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No Booked Packages Found'));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
