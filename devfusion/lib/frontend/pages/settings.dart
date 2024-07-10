import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/pages/lander.dart';
import 'package:flutter/material.dart';

import '../components/Button.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPref sharedPref = SharedPref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 110.0),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'League Spartan',
                      color: Color.fromRGBO(124, 58, 237, 1),
                      shadows: [
                        Shadow(
                          offset: Offset(0, 4.0),
                          blurRadius: 20.0,
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      ]),
                ),
                Button(
                  placeholderText: 'Logout',
                  backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
                  textColor: Colors.white,
                  onPressed: () {
                    sharedPref.removeToken();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Lander()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
