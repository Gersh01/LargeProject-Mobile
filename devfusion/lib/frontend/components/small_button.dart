import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String? placeholderText;

  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;

  const SmallButton(
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
        fontSize: 16,
      );
    } else {
      return textStyle!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
          top: 0,
          bottom: 0,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        placeholderText!,
        style: getTextStyle(),
      ),
    );
  }
}
