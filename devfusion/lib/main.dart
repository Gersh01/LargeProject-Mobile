import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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

class InputField extends StatelessWidget {

  final String? placeholderText;
  const InputField({
    super.key, this.placeholderText
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            placeholderText!,
            style: TextStyle(
              color: Colors.white,

            )),

          Center(
            child: TextField(
              style: TextStyle(
                color: Colors.white
              ),

              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeholderText,
                hintStyle: TextStyle(
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

