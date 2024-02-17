// ignore_for_file: camel_case_types

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'models/HomePageModel.dart';

class get_home_data extends StatefulWidget {
  const get_home_data({Key? key}) : super(key: key);

  @override
  State<get_home_data> createState() => _get_home_dataState();
}

class _get_home_dataState extends State<get_home_data> {
  late String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 150,
        width: 400,
        child: StreamBuilder(
          stream: FirebaseDatabase.instance
              .ref()
              .child("ArogyaSair/tblHospital")
              .onValue,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
              List<HomeData> hospitalList = [];
              hospitalList.clear();
              map.forEach((key, value) {
                hospitalList.add(HomeData.fromMap(value, key));
              });
              return GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // childAspectRatio: 10,
                    crossAxisCount: 1),
                itemCount: hospitalList.length,
                padding: const EdgeInsets.all(2.0),
                itemBuilder: (BuildContext context, int index) {
                  if (hospitalList[index].hospitalImage == null) {
                    imagePath =
                        "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2FArogyaSair.png?alt=media";
                  } else {
                    imagePath =
                        "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/HospitalImage%2F${hospitalList[index].hospitalImage}?alt=media";
                  }
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 15,
                        height: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                            image: DecorationImage(
                              image: NetworkImage(imagePath),
                              fit: BoxFit.cover,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          // child: Text(hospitalList[index].pname),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              gradient: LinearGradient(
                                  colors: [Colors.blue, Color(0x19000000)],
                                  begin: FractionalOffset(0.0, 1.0),
                                  end: FractionalOffset(0.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    hospitalList[index].hospitalName,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator(
                backgroundColor: Colors.redAccent,
                valueColor: AlwaysStoppedAnimation(Colors.green),
                strokeWidth: 1.5,
              );
            }
          },
        ),
      ),
    );
  }
}
