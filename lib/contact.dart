import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    void sendingMails() async {
      var url = Uri.parse("mailto:arogyasair@gmail.com");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    makingPhoneCall() async {
      var url = Uri.parse("tel:9016204659");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          const Row(
            children: [
              Text(
                'Address:',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                ' 123 Main Street, City, Country',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Phone: ',
                style: TextStyle(fontSize: 16.0),
              ),
              TextButton(
                onPressed: () {
                  makingPhoneCall();
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.zero), // Remove padding
                ),
                child: const Text(
                  '+91 9016204659',
                  style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                      decorationThickness: 2.0),
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text(
                'Email: ',
                style: TextStyle(fontSize: 16.0),
              ),
              TextButton(
                onPressed: () {
                  sendingMails();
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.zero), // Remove padding
                ),
                child: const Text(
                  'arogyasair@gmail.com',
                  style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                      decorationThickness: 2.0),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
