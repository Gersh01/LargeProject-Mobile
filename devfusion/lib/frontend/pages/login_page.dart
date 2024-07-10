import 'dart:convert';

import 'package:devfusion/frontend/pages/home.dart';
import 'package:flutter/material.dart';

import '../components/Button.dart';
import '../components/Divider.dart';
import '../components/InputField.dart';
import '../components/DevFusionColoredText.dart';
import 'package:http/http.dart' as http;
import '../utils/utility.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  void login(BuildContext context) async {
    // print('Username: ${_usernameController.text}');
    // print('Password: ${_passwordController.text}');

    // print(response.body);

    var reqBody = {
      "login": _usernameController.text,
      "password": _passwordController.text
    };

    var response = await http.post(
      Uri.parse(loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      print("login successful");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      print("login unsucessful");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Background
      home: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 110.0),
              child: Center(
                //Login Panel
                child: Container(
                  height: 520,
                  width: 370,
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(31, 41, 55, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      //DevFusion Text
                      const Padding(
                        padding: EdgeInsets.only(bottom: 50.0),
                        child: Column(
                          children: [
                            DevFusionColoredText(),
                            Center(
                              child: Text(
                                'login',
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              InputField(
                                  placeholderText: 'Username',
                                  controller: _usernameController,
                                  validator: usernameValidator),
                              InputField(
                                  placeholderText: 'Password',
                                  controller: _passwordController,
                                  validator: passwordValidator),
                              const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Remember Me',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text('Forgot Password',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      Button(
                        placeholderText: 'Login',
                        backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
                        textColor: Colors.white,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            login(context);
                          }
                        },
                      ),

                      const DividerLine(),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          child: const Text(
                            'Sign Up Instead',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
      ),
    );
  }
}
