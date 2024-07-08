
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

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      //Background
      home: Scaffold(
        body: Center(

          //Login Panel
          child: Container(
            height:636,
            width:370,
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(31, 41, 55, 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),

            child: Column(
              children: [

                const Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    children: [
                      DevFusionColoredText(),

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

                const Row(
                  children: [
                    Expanded(
                      child: InputField(placeholderText: 'First Name'),
                    ),

                    SizedBox(
                        width:10
                    ),

                    Expanded(
                        child: InputField(placeholderText: 'Last Name')
                    )
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    children: [
                      InputField(placeholderText: 'Username'),
                      InputField(placeholderText: 'Email'),
                      InputField(placeholderText: 'Password'),
                    ]
                  ),
                ),

                Button(placeholderText: 'Sign Up', backgroundColor: Color.fromRGBO(124, 58, 237, 1), textColor: Colors.white, onPressed: () {}),
                const Divider(),
                InkWell(
                  child:const Text('Login Instead',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500
                    )),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  }
                )
              ],
            )

          ),
        ),

          backgroundColor: const Color.fromRGBO(124, 58, 237, 1)
      ),
    );
  }
}
