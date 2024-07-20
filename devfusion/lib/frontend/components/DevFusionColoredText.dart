import 'package:flutter/material.dart';

class DevFusionColoredText extends StatelessWidget {
  final Color color;

  const DevFusionColoredText({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'DevFusion',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'League Spartan',
          color: color,
        ),
      ),
    );
  }
}
