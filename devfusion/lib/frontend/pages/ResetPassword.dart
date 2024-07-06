import 'package:flutter/material.dart';

import '../components/InputField.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Container(
              height: 520,
              width: 370,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(31, 41, 55, 1),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: const Column(
                children: [
                  
                  SizedBox(
                    height: 50.0
                  ),

                  Center(
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'League Spartan',
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 4.0),
                            blurRadius: 20.0,
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 50.0),

                  Center(
                    child: Text(
                      'Enter your email to reset your password',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'League Spartan',
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 4.0),
                            blurRadius: 20.0,
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InputField(placeholderText: 'Email')
                ],
              ),
            ),
          ),
          backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
        ),
      );
  }
}