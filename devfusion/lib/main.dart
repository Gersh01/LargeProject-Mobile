import 'package:flutter/material.dart';

import 'frontend/pages/ResetPassword.dart';

void main() {
  runApp( const MyApp() );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    bool obsdf = true;

    bool resetPassword = obsdf;

    if (resetPassword) {

      return const ResetPassword();
      
    } else {

        return MaterialApp(

          //Background
          home: Scaffold(
            body: Center(

              //Login Panel
              child: Container(
                height:520,
                width:370,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(31, 41, 55, 1),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),

                child: const Column(

                  children: [

                  //DevFusion Text
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

                    InputField(placeholderText: 'Username'),
                    InputField(placeholderText: 'Password'),

                    Row(
                      children: [
                        Text(
                          'Remember Me'
                        ),

                        Text(
                          'Forgot Password'
                        )
                      ],
                    )
                  ]
                )
              ),
            ),

          backgroundColor: const Color.fromRGBO(124, 58, 237, 1)
          ),
        );
      }

    }
}

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

