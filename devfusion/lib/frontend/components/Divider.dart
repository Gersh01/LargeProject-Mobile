import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget {
  const DividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 10, thickness: 1, indent: 10, endIndent: 10);
  }
}
