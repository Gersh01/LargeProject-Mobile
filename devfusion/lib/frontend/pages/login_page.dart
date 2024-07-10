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
import '../utils/validations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  List<String> fieldValidationErrors = <String>[""];
  double validationError = 0;

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

  Future<String> login(BuildContext context) async {
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
      return Future.value("");
    } else {
      print("login unsucessful");
      return Future.value("login unsucessful");
    }
  }

  // initLogin() async {
  //   SharedPref sharedPref = SharedPref();
  //   String? token = await sharedPref.readToken();
  //   // Future.delayed(const Duration(seconds: 2), () async {
  //   if (token != null) {
  //     var reqBody = {"token": token};

  //     var response = await http.post(
  //       Uri.parse(jwtUrl),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode(reqBody),
  //     );
  //     if (response.statusCode == 200) {
  //       var jsonResponse = jsonDecode(response.body);
  //       sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const Home()),
  //       );
  //     }
  //   }
  //   // });
  // }

  // @override
  // void initState() {
  //   initLogin();
  //   super.initState();
  // }

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
                  height: (520 + validationError),
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
                              Text(
                                fieldValidationErrors.reduce(
                                    (value, element) => value + '\n' + element),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
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
                            String loginResult = await login(context);
                            setState(() {
                              fieldValidationErrors = <String>[loginResult];
                              validationError = 10.toDouble() *
                                  fieldValidationErrors.length.toDouble();
                            });
                          } else {
                            setState(() {
                              fieldValidationErrors = validateLogin(
                                  _usernameController.text,
                                  _passwordController.text);
                              validationError = 10.toDouble() *
                                  fieldValidationErrors.length.toDouble();
                            });
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
