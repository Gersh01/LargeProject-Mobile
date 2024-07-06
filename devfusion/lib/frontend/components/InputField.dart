import 'package:flutter/material.dart';

class InputField extends StatelessWidget {

  final String? placeholderText;
  const InputField({
    super.key, this.placeholderText
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(

      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,


        children: [

          const DecoratedBox(decoration: BoxDecoration(
              color: Color.fromRGBO(124, 58, 237, 1)
              )),

          Text(
            placeholderText!,
            style: const TextStyle(
              color: Colors.white,

            )),

          Center(
            child: TextField(
              style: const TextStyle(
                color: Colors.white
              ),

              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeholderText,
                hintStyle: const TextStyle(
                  color: Colors.white
                )
              )
            ),
          ),
        ]
      ),
    ));
  }
}
