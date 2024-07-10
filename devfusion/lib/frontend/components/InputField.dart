import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? placeholderText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const InputField(
      {super.key, this.placeholderText, this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 64,
      margin: const EdgeInsets.only(bottom: 10),
      //Box Decoration
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color.fromRGBO(17, 24, 39, 1),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2.0),
              blurRadius: 2.0,
              color: Color.fromRGBO(0, 0, 0, 0.25),
            )
          ]),

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(placeholderText!,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                )),
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
                    ))),
          ),
        ]),
      ),
    ));
  }
}
