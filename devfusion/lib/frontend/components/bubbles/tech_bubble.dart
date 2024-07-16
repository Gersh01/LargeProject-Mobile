import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../utils/utility.dart';

class TechBubble extends StatefulWidget {
  final String technology;
  final bool editMode;
  final void Function(String techName)? delete;

  const TechBubble(
      {super.key,
      required this.technology,
      required this.editMode,
      this.delete});

  @override
  State<TechBubble> createState() => _TechBubbleState();
}

class _TechBubbleState extends State<TechBubble> {
  void deleteTechnology() {
    widget.delete!(widget.technology);
  }

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
        onDeleted: widget.editMode ? deleteTechnology : null,
        deleteIcon: widget.editMode
            ? const Icon(
                color: Colors.white,
                size: 20,
                Icons.remove_circle_outline,
              )
            : null);
  }
}
