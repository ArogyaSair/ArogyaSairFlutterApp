// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:arogyasair/HospitalHomePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'models/PackagesModel.dart';

class HospitalPackageAdd extends StatefulWidget {
  final String hospitalKey;

  const HospitalPackageAdd({Key? key, required this.hospitalKey})
      : super(key: key);

  @override
  _HospitalPackageAddState createState() => _HospitalPackageAddState();
}

class _HospitalPackageAddState extends State<HospitalPackageAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DatabaseReference dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblPackages');

  TextEditingController controllerpackagename = TextEditingController();
  TextEditingController controllerpackageprice = TextEditingController();
  TextEditingController controllerpackageincludes = TextEditingController();
  TextEditingController controllerhospitalname = TextEditingController();
  TextEditingController controllerpackageduration = TextEditingController();
  late String userKey;

  @override
  void initState() {
    super.initState();
    controllerhospitalname = TextEditingController(text: widget.hospitalKey);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Center(
                        child: Image.asset(
                          'assets/Logo/ArogyaSair.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerpackagename,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Package name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Package Name',
                        hintText: 'Package Name',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerpackageprice,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter price';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Package Price',
                        hintText: 'Package Price',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerpackageincludes,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter tests and reports Package include';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Package includes',
                        hintText: 'Package includes',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerhospitalname,
                      enabled: false,
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Hospital Name',
                        hintText: 'Hospital Name',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerpackageduration,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Duration(in Weeks)';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIconColor: Colors.blue,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Duration In Weeks',
                        hintText: 'Enter Durationn in Weeks',
                        filled: true,
                        fillColor: Color(0xffE0E3E7),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var name = controllerpackagename.text;
                          var price = controllerpackageprice.text;
                          var hospitalname = controllerhospitalname.text;
                          var duartion = controllerpackageduration.text;
                          var includes = controllerpackageincludes.text;
                          Packagemodel regobj = Packagemodel(
                              name, price, hospitalname, includes, duartion);
                          dbRef2.push().set(regobj.toJson());
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HospitalHomePage(0)),
                          );
                        }
                      },
                      child: const Text("Add"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
