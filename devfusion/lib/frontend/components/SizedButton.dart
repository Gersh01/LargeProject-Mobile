import 'package:flutter/material.dart';

class SizedButton extends StatelessWidget {
  final String? placeholderText;

  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double? width;

  const SizedButton(
      {super.key,
      this.placeholderText,
      this.backgroundColor,
      this.textColor,
      this.onPressed,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: onPressed,
              child: Text(placeholderText!,
                  style: TextStyle(
                      color: textColor,
                      fontFamily: 'League Spartan',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
