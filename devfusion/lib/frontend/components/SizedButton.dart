import 'package:flutter/material.dart';

class SizedButton extends StatelessWidget {
  final String? placeholderText;

  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final double? height;
  final double? width;

  const SizedButton(
      {super.key,
      this.placeholderText,
      this.backgroundColor,
      this.textColor,
      this.onPressed,
      this.textStyle,
      this.height,
      this.width});

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.zero, // Set this
                padding: const EdgeInsets.only(left: 5, right: 5),
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
      ),
    );
  }
}
