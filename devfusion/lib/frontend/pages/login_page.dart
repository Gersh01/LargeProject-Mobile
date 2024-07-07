
import 'package:flutter/material.dart';

import '../components/Button.dart';
import '../components/Divider.dart';
import '../components/InputField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  // final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

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
                const Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    children: [
                      Center(child: Text(
                        'Dev Fusion',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'League Spartan',
                          color: Color.fromRGBO(124, 58, 237, 1),
                          shadows: [ Shadow(
                            offset: Offset(0, 4.0),
                            blurRadius: 20.0,
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                          ),]
                        ),
                      )),

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
                ),


                const Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    children: [
                      InputField(placeholderText: 'Username'),
                      InputField(placeholderText: 'Password'),

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Remember Me', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500)
                            ),
                          ),

                          Text(
                              'Forgot Password', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500)
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                Button(placeholderText: 'Login', backgroundColor: const Color.fromRGBO(124, 58, 237, 1), textColor: Colors.white, onPressed: () => {}),
                
                const DividerLine(),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                      'Sign Up Instead', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ]
            )
          ),
        ),

      backgroundColor: const Color.fromRGBO(124, 58, 237, 1)
      ),
    );
  }
}