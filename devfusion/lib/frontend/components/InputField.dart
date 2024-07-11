import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? placeholderText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<String>? errorTextList;
  final double? errorCount;

  const InputField(
      {super.key,
      this.placeholderText,
      this.controller,
      this.validator,
      this.errorTextList,
      this.errorCount});

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
          color: Colors.red,
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }

  double getErrorCount() {
    if (errorCount == null) {
      return 0;
    } else {
      return errorCount!;
    }
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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: Color.fromRGBO(17, 24, 39, 1),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2.0),
                  blurRadius: 2.0,
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                ),
              ],
            ),

            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      placeholderText!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                    child: TextFormField(
                      validator: validator,
                      controller: controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: placeholderText,
                        errorStyle: const TextStyle(fontSize: 0),
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
