// ignore_for_file: file_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:path/path.dart';

import 'models/DoctorRegistrationModel.dart';
import 'models/DoctorSpecializationModel.dart';

class HospitalNewDoctorAdd extends StatefulWidget {
  const HospitalNewDoctorAdd({super.key});

  @override
  State<HospitalNewDoctorAdd> createState() => _HospitalNewDoctorAddState();
}

class _HospitalNewDoctorAddState extends State<HospitalNewDoctorAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DatabaseReference dbRef2 =
      FirebaseDatabase.instance.ref().child('ArogyaSair/tblDoctor');

  TextEditingController controlleruname = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();
  TextEditingController controllerconfirmpassword = TextEditingController();
  TextEditingController controllername = TextEditingController();
  TextEditingController controllermail = TextEditingController();
  TextEditingController controllerDateOfBirth = TextEditingController();
  TextEditingController controllerContact = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  var selectedValue = 0;
  var selectedGender;
  var birthDate = "Select Birthdate";
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  List<MultiSelectItem<String>> items2 = [];
  List<DoctorSpecializationModel> selectedItems2 = [];
  late String fileName;
  File? _image; // Make _image nullable
  var imagePath =
      "https://firebasestorage.googleapis.com/v0/b/arogyasair-157e8.appspot.com/o/UserImage%2FDefaultProfileImage.png?alt=media";

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        fileName = basename(_image!.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controllerDateOfBirth = TextEditingController(text: birthDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Doctor"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: _image != null
                              ? Image.file(_image!,
                                  height: 110, width: 110, fit: BoxFit.cover)
                              : Image.network(
                                  imagePath,
                                  height: 110,
                                  width: 110,
                                ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.cloud_upload,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Upload Image",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: () {
                            getImage();
                          },
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: controllername,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
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
                      labelText: 'Full Name',
                      hintText: 'Enter Name',
                      filled: true,
                      fillColor: Color(0xffE0E3E7),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      // height: 100,
                      width: double.maxFinite,
                      child: SingleChildScrollView(
                        child: StreamBuilder(
                          stream: FirebaseDatabase.instance
                              .ref()
                              .child("ArogyaSair/tblSpe")
                              .onValue,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data!.snapshot.value != null) {
                              Map<dynamic, dynamic> facilitiesMap =
                                  snapshot.data!.snapshot.value;
                              List<MultiSelectItem<DoctorSpecializationModel>>
                                  items2 = [];
                              items2.clear();
                              facilitiesMap.forEach((key, value) {
                                items2.add(
                                    MultiSelectItem<DoctorSpecializationModel>(
                                        DoctorSpecializationModel.fromMap(
                                            value, key),
                                        value["Specilization"]));
                              });
                              return Column(
                                children: <Widget>[
                                  MultiSelectBottomSheetField(
                                    initialChildSize: 0.4,
                                    listType: MultiSelectListType.CHIP,
                                    searchable: true,
                                    buttonText:
                                        const Text("Select Specialization"),
                                    title: const Text("Select Specialization"),
                                    items: items2,
                                    onConfirm: (values2) {
                                      selectedItems2 = values2
                                          .cast<DoctorSpecializationModel>();
                                    },
                                    chipDisplay: MultiSelectChipDisplay(
                                      onTap: (value2) {
                                        setState(() {
                                          selectedItems2.remove(value2);
                                        });
                                      },
                                    ),
                                  ),
                                  selectedItems2.isEmpty
                                      ? Container(
                                          padding: const EdgeInsets.all(10),
                                          alignment: Alignment.centerLeft,
                                          child: const Text(
                                            "None selected",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ))
                                      : Container(),
                                ],
                              );
                            } else {
                              return const CircularProgressIndicator(
                                backgroundColor: Colors.redAccent,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.green),
                                strokeWidth: 1.5,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controllermail,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIconColor: Colors.blue,
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Email',
                      hintText: 'Enter Email',
                      filled: true,
                      fillColor: Color(0xffE0E3E7),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controllerContact,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter contact number of doctor';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      prefixIconColor: Colors.blue,
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Contact number',
                      hintText: 'Enter contact number',
                      filled: true,
                      fillColor: Color(0xffE0E3E7),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controllerAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Doctor address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.streetAddress,
                    decoration: const InputDecoration(
                      prefixIconColor: Colors.blue,
                      prefixIcon: Icon(Icons.pin_drop),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Address',
                      hintText: 'Enter Address',
                      filled: true,
                      fillColor: Color(0xffE0E3E7),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controllerpassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controllerconfirmpassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter re-enter password';
                      }
                      return null;
                    },
                    obscureText: !isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          _toggleConfirmPasswordVisibility(context);
                        },
                      ),
                      prefixIconColor: Colors.blue,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      fillColor: const Color(0xffE0E3E7),
                      labelText: 'Confirm Password',
                      hintText: 'Re-Enter Password',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            const Text(
                              'Gender:',
                              style: TextStyle(fontSize: 18),
                            ),
                            Radio(
                              value: "Male",
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                            ),
                            const Text(
                              'Male',
                              style: TextStyle(fontSize: 18),
                            ),
                            Radio(
                              value: "Female",
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                            ),
                            const Text(
                              'Female',
                              style: TextStyle(fontSize: 18),
                            ),
                            Radio(
                              value: "Other",
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                            ),
                            const Text(
                              'Other',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controllerDateOfBirth,
                    readOnly: true,
                    // Make the text input read-only
                    decoration: InputDecoration(
                      prefixIcon: GestureDetector(
                        onTap: () {
                          _getDate(context);
                        },
                        child: const Icon(
                          Icons.date_range,
                          color: Colors.blue,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      fillColor: const Color(0xffE0E3E7),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var name = controllername.text;
                        var password = controllerpassword.text;
                        var confirmPassword = controllerconfirmpassword.text;
                        var gender = selectedGender;
                        var email = controllermail.text;
                        var dob = birthDate;
                        var contact = controllerContact.text;
                        var address = controllerAddress.text;
                        var password1 = password;
                        var specilization = selectedItems2
                            .map((item) => item.specialization)
                            .join(',');
                        if (password == confirmPassword) {
                          DoctorRegisterModel regobj = DoctorRegisterModel(
                              password1,
                              email,
                              name,
                              dob,
                              gender,
                              contact,
                              address,
                              fileName,
                              specilization);
                          uploadImage();
                          dbRef2.push().set(regobj.toJson());
                          Navigator.of(context).pop();
                        } else {
                          const snackBar = SnackBar(
                            content: Text("Password does not match..!!"),
                            duration: Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: const Text("Add Doctor"),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void _togglePasswordVisibility(BuildContext context) {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  Future<void> _getDate(BuildContext context) async {
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2090),
      dateFormat: "dd-MM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );
    setState(() {
      if (datePicked != null) {
        birthDate = "${datePicked.day}-${datePicked.month}-${datePicked.year}";
        controllerDateOfBirth = TextEditingController(text: birthDate);
      }
    });
  }

  void _toggleConfirmPasswordVisibility(BuildContext context) {
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }

  Future uploadImage() async {
    fileName = basename(_image!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("DoctorImage/$fileName");
    firebaseStorageRef.putFile(_image!);
  }
}
