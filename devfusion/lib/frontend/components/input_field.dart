import 'package:devfusion/themes/theme.dart';
import 'package:devfusion/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class InputField extends StatelessWidget {
  final String? placeholderText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<String>? errorTextList;
  final double? errorCount;
  final bool? isObscure;
  final IconButton? suffixIcon;
  final String? hintText;
  final Color backgroundColor;
  final Color color;

  const InputField({
    super.key,
    this.placeholderText,
    this.controller,
    this.validator,
    this.errorTextList,
    this.errorCount,
    this.isObscure,
    this.suffixIcon,
    this.hintText,
    required this.backgroundColor,
    required this.color,
  });

  Text? convertErrorsToText() {
    if (errorTextList == null) {
      return null;
    } else if (errorTextList![0] == "") {
      return null;
    } else {
      String errors = errorTextList![0];
      for (var i = 1; i < errorTextList!.length; i++) {
        errors = '$errors\n${errorTextList![i]}';
      }
      print(errors);
      return Text(
        errors,
        style: const TextStyle(
          color: danger,
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }

  String getHintText() {
    if (hintText != null) {
      return hintText!;
    } else {
      return placeholderText!;
    }
  }

  double getErrorCount() {
    if (errorCount == null) {
      return 0;
    } else {
      return errorCount!;
    }
  }

  bool getIsObscure() {
    if (isObscure == null) {
      return false;
    }
    return isObscure!;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 64,
            margin: const EdgeInsets.only(top: 8, bottom: 2),
            //Box Decoration
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              // color: Theme.of(context).primaryColorDark,
              // color: (Provider.of<ThemeProvider>(context).themeData == darkMode)
              //     ? darkPrimaryVariant
              //     : lightPrimaryVariant,
              color: backgroundColor,
            ),

            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Row(
                      children: [
                        //Chooses Icon for field based on placeholder text
                        placeholderText == 'Username'
                            ? Icon(Icons.account_circle_outlined,
                                color: color, size: 14)
                            : placeholderText == 'Password'
                                ? Icon(
                                    Icons.lock_open,
                                    size: 14,
                                    color: color,
                                  )
                                : placeholderText == 'Email'
                                    ? Icon(
                                        Icons.mail_outline,
                                        size: 14,
                                        color: color,
                                      )
                                    : Container(),

                        //Places padding between icon and text only if icon is present
                        placeholderText == 'Username'
                          ? const SizedBox(width: 5)
                        : placeholderText == 'Password'
                          ? const SizedBox(width: 5)
                        : placeholderText == 'Email'
                          ? const SizedBox(width: 5)
                        : Container(),

                        Text(
                          placeholderText!,
                          // style: Theme.of(context).textTheme.labelMedium,
                          style: TextStyle(
                              fontFamily: 'PoppinsSemibold',
                              fontSize: 14,
                              color: color),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22,
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      obscureText: getIsObscure(),
                      autocorrect: false,
                      validator: validator,
                      controller: controller,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: color,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(0.0, 1.0, 5.0, 1.0),
                        border: InputBorder.none,
                        // border: const OutlineInputBorder(),
                        hintText: getHintText(),
                        errorStyle: const TextStyle(fontSize: 0),
                        hintStyle: TextStyle(
                          color: color,
                          fontSize: 14,
                          fontFamily: 'PoppinsSemibold',
                        ),
                        // hintStyle: Theme.of(context)
                        //     .textTheme
                        //     .bodySmall
                        //     ?.copyWith(color: color),
                        suffixIcon: Transform.scale(
                          scale: 1,
                          child: suffixIcon,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 9.5),
              child: SizedBox(
                height: (15 * errorCount!).toDouble(),
                child: convertErrorsToText(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
