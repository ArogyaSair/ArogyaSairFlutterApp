import 'package:arogyasair/BottomNavigation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'drawerSideNavigation.dart';

void addFAQsToFirebase() async {
  final databaseReference = FirebaseDatabase.instance.ref("ArogyaSair/tblFAQ");

  for (var faq in faqs) {
    databaseReference.child('faqs').push().set({
      'question': faq['question'],
      'answer': faq['answer'],
    });
  }
}

class MyHelpDesk extends StatefulWidget {
  const MyHelpDesk({super.key});

  @override
  State<MyHelpDesk> createState() => _MyHelpDeskState();
}

class _MyHelpDeskState extends State<MyHelpDesk> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Text(
          'Arogya Sair',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      endDrawer: const DrawerCode(),
      bottomNavigationBar: const bottomBar(),
      body: ListView.builder(
        itemCount: faqs.length + 1, // Add 1 for the additional card
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 8,
                  margin: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.blue.shade600, Colors.blue.shade200],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: Center(
                        child: Lottie.asset(
                          'assets/Animation/help_desk.json',
                          repeat: true,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _textFieldController,
                          decoration: const InputDecoration(
                            hintText: 'Ask a question...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_textFieldController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please write something to get a response for your query'),
                                ),
                              );
                            } else {
                              // Handle submit logic
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue.shade200, // Change color here
                            ),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.deepPurple),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return ExpansionTile(
              title: Text(faqs[index - 1]['question']!),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(faqs[index - 1]['answer']!),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

List<Map<String, String>> faqs = [
  {
    'question': 'How do I book an appointment?',
    'answer':
        'You can book an appointment by visiting our website or calling our reception.'
  },
  {
    'question': 'What are your opening hours?',
    'answer': 'We are open from 8:00 AM to 5:00 PM, Monday to Friday.'
  },
  {
    'question': 'Is parking available at the hospital?',
    'answer': 'Yes, we have parking facilities available for patients.'
  },
  {
    'question': 'Do you accept insurance?',
    'answer':
        'Yes, we accept most major insurance plans. Please check with your insurance provider for details.'
  },
  {
    'question': 'What should I bring for my appointment?',
    'answer':
        'Please bring your ID, insurance card, and any relevant medical records.'
  },
  {
    'question': 'How can I pay my bill?',
    'answer':
        'You can pay your bill online, by phone, or in person at our reception.'
  },
  {
    'question': 'Do you offer telemedicine services?',
    'answer':
        'Yes, we offer telemedicine appointments. Please contact us for more information.'
  },
  {
    'question': 'Can I request a prescription refill online?',
    'answer':
        'Yes, you can request a prescription refill through our website or patient portal.'
  },
  {
    'question': 'What languages do your staff speak?',
    'answer':
        'Our staff speaks English, Spanish, and Mandarin. Interpretation services are also available for other languages.'
  },
  {
    'question': 'How can I access my medical records?',
    'answer':
        'You can access your medical records through our patient portal or by requesting them in person.'
  },
  {
    'question': 'Do you offer financial assistance programs?',
    'answer':
        'Yes, we offer financial assistance programs for qualifying patients. Please contact our billing department for more information.'
  },
  {
    'question': 'What should I do if I need medical advice after hours?',
    'answer':
        'If you need medical advice after hours, please call our main number and follow the prompts to speak with a healthcare provider.'
  },
  {
    'question': 'Can I schedule appointments for family members?',
    'answer':
        'Yes, you can schedule appointments for family members. Please have their information ready when you call.'
  },
  {
    'question': 'Do you offer online check-in?',
    'answer':
        'Yes, you can check in online for your appointment. Please visit our website for more information.'
  },
  {
    'question': 'How can I provide feedback about my experience?',
    'answer':
        'You can provide feedback about your experience through our website or by contacting our patient relations department.'
  },
  {
    'question': 'Can I request a copy of my medical records?',
    'answer':
        'Yes, you can request a copy of your medical records. Please contact our medical records department for more information.'
  },
  {
    'question': 'What should I do if I have a medical emergency?',
    'answer':
        'If you have a medical emergency, please call 911 or go to the nearest emergency room.'
  },
  {
    'question': 'How do I get a referral to a specialist?',
    'answer':
        'You can get a referral to a specialist from your primary care physician.'
  },
  {
    'question': 'Do you offer virtual visits?',
    'answer':
        'Yes, we offer virtual visits for certain appointments. Please contact us for more information.'
  },
  {
    'question': 'Can I request an appointment for a specific provider?',
    'answer':
        'Yes, you can request an appointment with a specific provider. Please let us know when you schedule your appointment.'
  },
];
