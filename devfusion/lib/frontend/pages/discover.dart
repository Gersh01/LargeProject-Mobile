import 'package:flutter/material.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Discover',
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