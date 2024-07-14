import 'package:flutter/material.dart';

class DevFusionColoredText extends StatelessWidget {
  const DevFusionColoredText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'DevFusion',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'League Spartan',
          color: Color.fromRGBO(124, 58, 237, 1),
        ),
      ),
    );
  }
}
