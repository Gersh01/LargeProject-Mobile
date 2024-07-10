import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Settings',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'League Spartan',
            color: Color.fromRGBO(124, 58, 237, 1),
            shadows: [ Shadow(
              offset: Offset(0, 4.0),
              blurRadius: 20.0,
              color: Color.fromRGBO(0, 0, 0, 0.4),
            ),]
          ),
        ),
      )
    );
  }
}