import 'package:flutter/material.dart';
import '../Standardizations/dvColors.dart';

class Button extends StatelessWidget{

  final String? placeholderText;
  const Button({
    super.key, this.placeholderText
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(

            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                backgroundColor:const Color.fromRGBO(124, 58, 237, 1),
                shape:const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),


              ),

              onPressed:() {},
              child: Text(
                placeholderText!,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'League Spartan',
                  fontSize: 20,

                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}