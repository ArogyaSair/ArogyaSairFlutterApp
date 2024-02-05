import 'package:arogyasair/profile.dart';
import 'package:arogyasair/radio.dart';
import 'package:flutter/material.dart';

import 'about.dart';
import 'contact.dart';
import 'order.dart';

class DrawerCode extends StatelessWidget {
  const DrawerCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          // image: AssetImage('assets/demo.png'),
                          image: AssetImage('assets/ArogyaSair.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                const Text(
                  'Arogya Sair',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const Text(
                  'Admin',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const profile()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About us"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const about()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.call),
            title: const Text("Contact us"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const contact()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Order Details"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const order()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.radio_button_checked),
            title: const Text("Radio Button"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const radio()));
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.tab),
          //   title: const Text("Test 1(Radio Button)"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => test1()));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.tab),
          //   title: const Text("Test 2(CheckBox)"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => checkSample()));
          //   },
          // ),
        ],
      ),
    );
  }
}
