import 'package:flutter/material.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Projects',
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