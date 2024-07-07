import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget{
  const DividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 2,
        color: const Color.fromRGBO(17, 24, 39, 1),
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}