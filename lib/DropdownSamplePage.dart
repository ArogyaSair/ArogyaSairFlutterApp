// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

class DropdownSamplePage extends StatefulWidget {
  final listOfValuesForKey1;

  const DropdownSamplePage(this.listOfValuesForKey1, {super.key});

  @override
  _DropdownSampleState createState() => _DropdownSampleState();
}

class _DropdownSampleState extends State<DropdownSamplePage> {
  String? dropdownvalue = 'Select Doctor';
  late List<String> data;
  List<String> items = [
    'Apple',
    'Banana',
    'Grapes',
    'Orange',
    'watermelon',
    'Pineapple'
  ];

  @override
  void initState() {
    super.initState();
    data = widget.listOfValuesForKey1;
    // print(data);
    // print(widget.listOfValuesForKey1);
    // print(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Navigator Drawer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.arrow_drop_down),
              items: data.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Alert Message"),
                        content: Text("You Selected $dropdownvalue"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
