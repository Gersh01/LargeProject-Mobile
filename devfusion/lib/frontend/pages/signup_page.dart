import 'dart:convert';

import 'package:flutter/material.dart';

import '../components/Button.dart';
import '../components/Divider.dart';
import '../components/InputField.dart';
import '../components/DevFusionColoredText.dart';
import 'package:http/http.dart' as http;
import '../utils/utility.dart';

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

  final formKey = GlobalKey<FormState>();

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First Name is required';
    }

    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last Name is required';
    }

    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    return null;
  }

  // validate email

  void signUp() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    print('First Name: ${_firstNameController.text}');
    print('Last Name: ${_lastNameController.text}');
    print('Username: ${_usernameController.text}');
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');

    var reqBody = {
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      "password": _passwordController.text,
      "username": _usernameController.text,
      "email": _emailController.text
    };

    var response = await http.post(
      Uri.parse(registerUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Background
      home: Scaffold(
          body: Center(
            //Login Panel
            child: Container(
                height: 636,
                width: 370,
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
                                ]),
                          )),
                        ],
                      ),
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: InputField(
                                      placeholderText: 'First Name',
                                      controller: _firstNameController,
                                      validator: validateUsername),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: InputField(
                                        placeholderText: 'Last Name',
                                        controller: _lastNameController,
                                        validator: validateUsername))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: Column(children: [
                                InputField(
                                    placeholderText: 'Username',
                                    controller: _usernameController,
                                    validator: validateUsername),
                                InputField(
                                    placeholderText: 'Email',
                                    controller: _emailController,
                                    validator: validateEmail),
                                InputField(
                                    placeholderText: 'Password',
                                    controller: _passwordController,
                                    validator: validatePassword),
                              ]),
                            ),
                          ],
                        )),
                    Button(
                        placeholderText: 'Sign Up',
                        backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
                        textColor: Colors.white,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            signUp();
                          }
                        }),
                    const Divider(),
                    InkWell(
                        child: const Text('Login Instead',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500)),
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        })
                  ],
                )),
          ),
          backgroundColor: const Color.fromRGBO(124, 58, 237, 1)),
    );
  }
}
