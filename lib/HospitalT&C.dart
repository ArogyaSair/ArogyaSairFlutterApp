// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Terms & Conditions of The Arogya Sair App :',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            buildTerm(
              '1. Accepting the Terms & Conditions Form:',
              'Respective Hospital, by accepting The Terms and Conditions Form, you are agreeing with us completely that you will follow all the rules and regulations of the app and will not violate our accepted consent.',
            ),
            buildTerm(
              '2. App Motive:',
              'The Arogya Sair App is for providing the hospital services and appointment scheduling from a verified list of the trusted hospitals in the country. This app is not a substitute for medical advice, diagnosis, or any treatment.',
            ),
            buildTerm(
              '3. Hospital Responsibilities Regarding Their Data:',
              'For each and every data that is provided by you should be accurate and recognized. Data of Login Credentials are confidential and that\'s why we suggest you to ensure the data before you continue to our security terms of Login Credentials. You are responsible for any Misuse or Unauthorized Access. Also, any Misuse and Unauthorized Access is Strictly Prohibited.',
            ),
            buildTerm(
              '4. Privacy and Data Security:',
              'Hospital\'s Data is governed under the App\'s Privacy Policy. Hospital should be careful before providing their personal data to anyone and has to take reasonable measures to secure their information as well as precautions to protect their personal data.',
            ),
            buildTerm(
              '5. Intellectual Property of the App:',
              'All the Contents, Trademarks and Intellectual Property Rights associated with the App are owned by the App itself. Hospital may not reproduce, distribute, or modify any content without prior written consent.',
            ),
            buildTerm(
              '6. Appointment Scheduling & Treatment Price:',
              'The Hospital can arrange appointment scheduling based on the availability of themselves. The rate of operations, including appointment slots and service hours, hospital can apply according to application\'s limited contract that is Minimum to Maximum Charges that is also described along with the package that hospital can select according to their perspective of time intervals and other factors as it is a subject to the Hospital\'s discretion.',
            ),
            buildTerm(
              '7. Payment & Billing:',
              'Hospital agree to pay for services as outlined in the Billing Section of the App. Rates for Medical Services and any Associated Fees will be Transparently Communicated.',
            ),
            buildTerm(
              '8. Termination of Services:',
              'The Arogya Sair app reserves the Right to Terminate or Suspend Hospital Access to the App for any Reason, including Violation of these Terms and Conditions.',
            ),
            buildTerm(
              '9. Changes to terms:',
              'The App may Update these Terms Periodically, and Hospital will be Notified of Such Changes. Continued use of the App after changes Implies Acceptance of the Updated Terms.',
            ),
            buildTerm(
              '10. Governing Law:',
              'These Terms and Conditions are Governed by the Laws of the Jurisdiction.',
            ),
            buildTerm(
              '11. Upload Hospital\'s Terms & Conditions Form Without Violating The App\'s Terms & Conditions:',
              'Hospital Terms & Conditions should not Violate the App\'s Terms & Conditions. If happens then A Warning will Appear and within 24 Hours that T&C shall be Removed otherwise Strict Action will be taken.',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTerm(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          content,
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
