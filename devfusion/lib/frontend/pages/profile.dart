import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Profile',
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