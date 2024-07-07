import 'package:flutter/material.dart';
import 'frontend/components/InputField.dart';
import 'frontend/components/Button.dart';
import 'frontend/components/Divider.dart';

void main() {
  runApp( const MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

            child: const Column(

              children: [

              //DevFusion Text
                Padding(
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


                Padding(
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

                Button(placeholderText: 'Login'),
                DividerLine(),
                Padding(
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



