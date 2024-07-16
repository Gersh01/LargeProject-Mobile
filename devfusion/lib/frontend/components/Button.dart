import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? placeholderText;

  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;

  const Button(
      {super.key,
      this.placeholderText,
      this.backgroundColor,
      this.textColor,
      this.onPressed,
      this.textStyle});

  getTextStyle() {
    if (textStyle == null) {
      return TextStyle(
          color: textColor,
          fontFamily: 'League Spartan',
          fontSize: 20,
          fontWeight: FontWeight.bold);
    } else {
      return textStyle!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
            onPressed: onPressed,
            child: Text(
              placeholderText!,
              style: getTextStyle(),
            ),
          ),
        ),
      ],
    );
  }
}
