import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          'Contact',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Address: 123 Main Street, City, Country',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Phone: +1 234 567 890',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Email: info@arogyasair.com',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
