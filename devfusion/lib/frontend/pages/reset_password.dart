import 'package:flutter/material.dart';

import '../components/Button.dart';
import '../components/InputField.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {

    final TextEditingController _emailController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    void resetPassword() {

      final isValid = formKey.currentState!.validate();

      if (!isValid) {
        return;
      }

      


      print('Email: ${_emailController.text}');
    }

    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      }

      return null;
    }
    
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
                  padding: EdgeInsets.only(bottom: 20.0),
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
                      )),

                      SizedBox(
                        height: 50,
                      ),
                      
                      Center(child: Text(
                        'Enter your email to reset password.',
                        style: TextStyle(
                          fontSize: 14,
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
                ),


                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                    children: [
                      InputField(placeholderText: 'Email', controller: _emailController, validator: validateEmail),
                      const SizedBox(height: 20),
                      Button(placeholderText: 'Login', backgroundColor: const Color.fromRGBO(124, 58, 237, 1), textColor: Colors.white, onPressed: resetPassword)
                    ]
                    ),
                  ),
                    
                )
              ]
            ),
          ),
          ),
        backgroundColor: const Color.fromRGBO(124, 58, 237, 1)
        ),
      );
  }
}