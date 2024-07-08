
import 'package:flutter/material.dart';

import '../components/Button.dart';
import '../components/Divider.dart';
import '../components/InputField.dart';
import '../components/DevFusionColoredText.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      //Background
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
                  const Column(
                    children: [
                      DevFusionColoredText(),

                      //Signup Text
                      Center(child: Text(
                        'login',
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
                      )),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InputField(placeholderText: 'First Name'),

                            SizedBox(
                              width: 10
                            ),

                            InputField(placeholderText: 'Last Name')
                          ],
                        ),

                        InputField(placeholderText: 'Username'),
                        InputField(placeholderText: 'Email'),
                        InputField(placeholderText: 'Password'),
                      ],
                    )
                  ),

                  const Button(placeholderText: 'Signup', backgroundColor: Color.fromRGBO(124, 58, 237, 1), textColor: Colors.white),

                  const DividerLine(),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      child: const Text('Sign Up Instead'),
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      }
                    )
                  ),
                ],
              ),
          ),
        ),

          backgroundColor: const Color.fromRGBO(124, 58, 237, 1)
      ),
    );
  }
}