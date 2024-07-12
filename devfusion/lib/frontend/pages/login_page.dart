import 'dart:convert';

import 'package:devfusion/frontend/components/shared_pref.dart';
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

  List<String>? usernameErrorList;
  double usernameErrorDouble = 0;
  List<String>? passwordErrorList;
  double passwordErrorDouble = 0;

  bool passwordVisible = true;

  final formKey = GlobalKey<FormState>();

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        usernameErrorList = ["Username is required"];
        usernameErrorDouble = 1;
      });
      return 'Username is required';
    } else {
      setState(() {
        usernameErrorList = null;
        usernameErrorDouble = 0;
      });
      return null;
    }
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        passwordErrorList = ["Password is required"];
        passwordErrorDouble = 1;
      });
      return 'Password is required';
    } else {
      setState(() {
        passwordErrorList = null;
        passwordErrorDouble = 0;
      });
      return null;
    }
  }

  void login(BuildContext context) async {
    SharedPref sharedPref = SharedPref();

    var reqBody = {
      "login": _usernameController.text,
      "password": _passwordController.text,
      "rememberMe": true
    };

    var response = await http.post(
      Uri.parse(loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      print("login successful");
      var jsonResponse = jsonDecode(response.body);
      sharedPref.writeToken(jwtToken: jsonResponse['token']);
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    } else {
      print("login unsucessful");
      setState(() {
        passwordErrorList = ["Login Unsucessful"];
        passwordErrorDouble = 1;
      });
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
                  height:
                      510 + (12 * (usernameErrorDouble + passwordErrorDouble)),
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
                                'Login',
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
                                validator: usernameValidator,
                                errorTextList: usernameErrorList,
                                errorCount: usernameErrorDouble,
                              ),
                              InputField(
                                placeholderText: 'Password',
                                isObscure: passwordVisible,
                                controller: _passwordController,
                                validator: passwordValidator,
                                errorTextList: passwordErrorList,
                                errorCount: passwordErrorDouble,
                                suffixIcon: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Row(
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
                                    Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
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
