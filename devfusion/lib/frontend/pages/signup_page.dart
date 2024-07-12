import 'dart:convert';

import 'package:flutter/material.dart';

import '../components/Button.dart';
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

  List<String>? firstNameErrorList;
  double firstNameErrorDouble = 0;
  List<String>? lastNameErrorList;
  double lastNameErrorDouble = 0;
  List<String>? usernameErrorList;
  double usernameErrorDouble = 0;
  List<String>? emailErrorList;
  double emailErrorDouble = 0;
  List<String>? passwordErrorList;
  double passwordErrorDouble = 0;

  final formKey = GlobalKey<FormState>();

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        firstNameErrorList = ['First Name is required'];
        firstNameErrorDouble = 1;
      });
      return 'First Name is required';
    } else if (value.length > 18) {
      setState(() {
        firstNameErrorList = ['First Name is too long'];
        firstNameErrorDouble = 1;
      });
      return 'First Name is too long';
    } else {
      setState(() {
        firstNameErrorList = null;
        firstNameErrorDouble = 0;
      });
      return null;
    }
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        lastNameErrorList = ['Last Name is required'];
        lastNameErrorDouble = 1;
      });
      return 'Last Name is required';
    } else if (value.length > 18) {
      setState(() {
        lastNameErrorList = ['Last Name is too long'];
        lastNameErrorDouble = 1;
      });
      return 'Last Name is too long';
    } else {
      setState(() {
        lastNameErrorList = null;
        lastNameErrorDouble = 0;
      });
      return null;
    }
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        usernameErrorList = ['Username is required'];
        usernameErrorDouble = 1;
      });
      return 'Username is required';
    } else if (value.length > 24) {
      setState(() {
        usernameErrorList = ['Username is too long'];
        usernameErrorDouble = 1;
      });
      return 'Username is too long';
    } else {
      setState(() {
        usernameErrorList = null;
        usernameErrorDouble = 0;
      });
      return null;
    }
  }

  String? validatePassword(String? value) {
    final validPassword =
        RegExp(r'(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&])(?=.{8,24}$)');
    if (value == null || value.isEmpty) {
      setState(() {
        passwordErrorList = ['Password is required'];
        passwordErrorDouble = 1;
      });
      return 'Password is required';
    } else if (!validPassword.hasMatch(value)) {
      setState(() {
        passwordErrorList = ['Password does not follow the correct format'];
        passwordErrorDouble = 1;
      });
      return 'Password does not follow the correct format';
    } else {
      setState(() {
        passwordErrorList = null;
        passwordErrorDouble = 0;
      });
      return null;
    }
  }

  String? validateEmail(String? value) {
    final validEmail =
        RegExp(r'^[a-zA-Z0-9._:$!%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value == null || value.isEmpty) {
      setState(() {
        emailErrorList = ['Email is required'];
        emailErrorDouble = 1;
      });
      return 'Email is required';
    } else if (!validEmail.hasMatch(value)) {
      setState(() {
        emailErrorList = ['Email must follow example@email.com format'];
        emailErrorDouble = 1;
      });
      return 'Email must follow example@email.com format';
    } else {
      setState(() {
        emailErrorList = null;
        emailErrorDouble = 0;
      });
      return null;
    }
  }

  // validate email

  void signUp() async {
    // print('First Name: ${_firstNameController.text}');
    // print('Last Name: ${_lastNameController.text}');
    // print('Username: ${_usernameController.text}');
    // print('Email: ${_emailController.text}');
    // print('Password: ${_passwordController.text}');

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

    if (response.statusCode == 201) {
      setState(() {
        passwordErrorList = ["Registration is successful"];
        passwordErrorDouble = 1;
      });
      print("Register successful");
    } else {
      setState(() {
        passwordErrorList = ["Registration is unsuccessful"];
        passwordErrorDouble = 1;
      });
      print("Register unsucessful");
    }

    // print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Background

      home: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Center(
                child: Container(
                  height: 750,
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
                      const Padding(
                        padding: EdgeInsets.only(bottom: 50.0),
                        child: Column(
                          children: [
                            DevFusionColoredText(),
                            Center(
                              child: Text(
                                'Sign Up',
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
                                    validator: validateFirstName,
                                    errorTextList: firstNameErrorList,
                                    errorCount: firstNameErrorDouble,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: InputField(
                                    placeholderText: 'Last Name',
                                    controller: _lastNameController,
                                    validator: validateLastName,
                                    errorTextList: lastNameErrorList,
                                    errorCount: lastNameErrorDouble,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: Column(
                                children: [
                                  InputField(
                                    placeholderText: 'Username',
                                    controller: _usernameController,
                                    validator: validateUsername,
                                    errorTextList: usernameErrorList,
                                    errorCount: usernameErrorDouble,
                                  ),
                                  InputField(
                                    placeholderText: 'Email',
                                    controller: _emailController,
                                    validator: validateEmail,
                                    errorTextList: emailErrorList,
                                    errorCount: emailErrorDouble,
                                  ),
                                  InputField(
                                    placeholderText: 'Password',
                                    controller: _passwordController,
                                    validator: validatePassword,
                                    errorTextList: passwordErrorList,
                                    errorCount: passwordErrorDouble,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Button(
                        placeholderText: 'Sign Up',
                        backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
                        textColor: Colors.white,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            signUp();
                          }
                        },
                      ),
                      const Divider(),
                      InkWell(
                        child: const Text('Login Instead',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500)),
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          //Login Panel
        ),
        backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
      ),
    );
  }
}
