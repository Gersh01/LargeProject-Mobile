import 'dart:convert';

import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:flutter/material.dart';

import '../components/Button.dart';
import '../components/input_field.dart';
import '../components/DevFusionColoredText.dart';
import 'package:http/http.dart' as http;
import '../utils/utility.dart';
import '/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:devfusion/themes/theme_provider.dart';

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
              padding: const EdgeInsets.only(top: 110.0),
              child: Center(
                //Login Panel
                child: Container(
                  height:
                      510 + (12 * (usernameErrorDouble + passwordErrorDouble)),
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
                      //DevFusion Text
                      Padding(
                        padding: EdgeInsets.only(bottom: 50.0),
                        child: Column(
                          children: [
                            DevFusionColoredText(
                                color: Theme.of(context).focusColor),
                            Center(
                              child: Text(
                                'Login',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
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
                                color: Theme.of(context).hintColor,
                                placeholderText: 'Username',
                                controller: _usernameController,
                                validator: usernameValidator,
                                errorTextList: usernameErrorList,
                                errorCount: usernameErrorDouble,
                              ),
                              InputField(
                                color: Theme.of(context).hintColor,
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, right: 1.0),
                                    child: InkWell(
                                      child: Text(
                                        'Forgot Password',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/forgotPassword');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      Button(
                        placeholderText: 'Login',
                        backgroundColor: Theme.of(context).focusColor,
                        textColor: Colors.white,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            login(context);
                          }
                        },
                      ),

                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          child: Text(
                            'Sign Up Instead',
                            style: Theme.of(context).textTheme.bodySmall
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
        backgroundColor: Theme.of(context).focusColor,
      ),
    );
  }
}
