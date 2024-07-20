import 'dart:convert';

import 'package:flutter/material.dart';

import '../components/Button.dart';
import '../components/input_field.dart';
import '../components/DevFusionColoredText.dart';
import 'package:http/http.dart' as http;
import '../utils/utility.dart';
import '/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:devfusion/themes/theme_provider.dart';

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

  bool passwordVisible = true;

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
    List<String> errorsList = [];
    final hasUpperCase =
        RegExp(r'(?=.*[A-Z])'); // At least one uppercase letter
    final hasDigit = RegExp(r'(?=.*[0-9])'); // At least one digit
    final hasSpecialChar = RegExp(
        r'(?=.*[!@#$%^&])'); // At least one special character from the set !@#$%^&
    final validLength =
        RegExp(r'(?=.{8,24}$)'); // Length between 8 and 24 characters

    double counter = 0;
    if (value == null || value.isEmpty) {
      errorsList.add('Password cannot be empty');
      counter++;
    } else {
      if (!validLength.hasMatch(value)) {
        errorsList.add('Password must be between 8 and 24 characters long');
        counter++;
      }
      if (!hasUpperCase.hasMatch(value)) {
        errorsList.add('Password must contain at least one uppercase letter');
        counter++;
      }
      if (!hasDigit.hasMatch(value)) {
        errorsList.add('Password must contain at least one digit');
        counter++;
      }
      if (!hasSpecialChar.hasMatch(value)) {
        errorsList.add('Password must contain at least one special character');
        counter++;
      }
    }

    counter *= 2;

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
        passwordErrorList = errorsList;
        passwordErrorDouble = counter;
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
      theme: (Provider.of<ThemeProvider>(context).themeData == null)
          ? lightMode
          : Provider.of<ThemeProvider>(context).themeData,
      darkTheme: (Provider.of<ThemeProvider>(context).themeData == null)
          ? darkMode
          : Provider.of<ThemeProvider>(context).themeData,
      //Background
      home: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Center(
                child: Container(
                  height: 650 +
                      (12 *
                          (firstNameErrorDouble +
                              lastNameErrorDouble +
                              usernameErrorDouble +
                              emailErrorDouble +
                              passwordErrorDouble)),
                  width: 370,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: Column(
                          children: [
                            DevFusionColoredText(
                                color: Theme.of(context).focusColor),
                            Center(
                              child: Text('Sign Up',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontSize: 18)),
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
                                    backgroundColor:
                                        Theme.of(context).primaryColorDark,
                                    color: Theme.of(context).hintColor,
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
                                    backgroundColor:
                                        Theme.of(context).primaryColorDark,
                                    color: Theme.of(context).hintColor,
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
                                    backgroundColor:
                                        Theme.of(context).primaryColorDark,
                                    color: Theme.of(context).hintColor,
                                    placeholderText: 'Username',
                                    controller: _usernameController,
                                    validator: validateUsername,
                                    errorTextList: usernameErrorList,
                                    errorCount: usernameErrorDouble,
                                  ),
                                  InputField(
                                    backgroundColor:
                                        Theme.of(context).primaryColorDark,
                                    color: Theme.of(context).hintColor,
                                    placeholderText: 'Email',
                                    controller: _emailController,
                                    validator: validateEmail,
                                    errorTextList: emailErrorList,
                                    errorCount: emailErrorDouble,
                                  ),
                                  InputField(
                                    backgroundColor:
                                        Theme.of(context).primaryColorDark,
                                    color: Theme.of(context).hintColor,
                                    placeholderText: 'Password',
                                    isObscure: passwordVisible,
                                    controller: _passwordController,
                                    validator: validatePassword,
                                    errorTextList: passwordErrorList,
                                    errorCount: passwordErrorDouble,
                                    suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Theme.of(context).hintColor,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Button(
                        placeholderText: 'Sign Up',
                        backgroundColor: Theme.of(context).focusColor,
                        textColor: Colors.white,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            signUp();
                          }
                        },
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          child: Text('Login Instead',
                              style: Theme.of(context).textTheme.bodySmall),
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          //Login Panel
        ),
        backgroundColor: Theme.of(context).focusColor,
      ),
    );
  }
}
