import 'package:flutter/material.dart';

import '../utils/utility.dart';

class TechBubble extends StatefulWidget {

  final String technology;

  const TechBubble({super.key, required this.technology});

  @override
  State<TechBubble> createState() => _TechBubbleState();
}

class _TechBubbleState extends State<TechBubble> {
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        widget.technology,
        
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: getBubbleColor(widget.technology),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: getBubbleColor(widget.technology),
        ),
      ),
    );
  }
}