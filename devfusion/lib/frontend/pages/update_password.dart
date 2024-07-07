import 'package:flutter/material.dart';

import '../components/Button.dart';
import '../components/InputField.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
        home: Scaffold(
        body: Center(

          //Login Panel
          child: Container(
            height:520,
            width:370,
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(31, 41, 55, 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),

            child: Column(

              children: [

              //DevFusion Text
                const Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 90,
                      ),
                      Center(child: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'League Spartan',
                          color:  Colors.white,
                          shadows: [  Shadow(
                            offset: Offset(0, 4.0),
                            blurRadius: 20.0,
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                          )]
                        ),
                      ))
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Column(
                    children: [
                      const InputField(placeholderText: 'Password'),
                      const InputField(placeholderText: 'Confirm Password'),
                      const SizedBox(height: 20),
                      Button(placeholderText: 'Login', backgroundColor: const Color.fromRGBO(124, 58, 237, 1), textColor: Colors.white, onPressed: () => {})
                    ]
                  ),
                ),
              ]
            ),
          ),
          ),
        backgroundColor: const Color.fromRGBO(124, 58, 237, 1)
        ),
      );
  }
}