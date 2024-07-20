import 'dart:convert';

import 'package:devfusion/frontend/utils/utility.dart';
import 'package:flutter/material.dart';

import '../components/Button.dart';
import '../components/input_field.dart';

import 'package:http/http.dart' as http;

import '/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:devfusion/themes/theme_provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  List<String>? emailErrorList;
  double emailErrorDouble = 0;

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

  void sendForgotPassword() async {
    var reqBody = {"email": _emailController.text};

    var response = await http.post(
      Uri.parse(forgotPasswordUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("resend email verification successful");
      setState(() {
        emailErrorList = ["Email Sent"];
        emailErrorDouble = 1;
      });
    } else {
      print("resend email verification unsucessful");
      setState(() {
        emailErrorList = [jsonResponse["error"]];
        emailErrorDouble = 1;
      });
    }
    print('Email: ${_emailController.text}');
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return MaterialApp(
      theme: (Provider.of<ThemeProvider>(context).themeData == null)
          ? lightMode
          : Provider.of<ThemeProvider>(context).themeData,
      darkTheme: (Provider.of<ThemeProvider>(context).themeData == null)
          ? darkMode
          : Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: IconButton(
                icon:
                    Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
        body: Center(
          child: Container(
            height: 300 + (10 * emailErrorDouble),
            width: 370,
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      // Center(
                      Text(
                        'Forgot Password',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18)
                      ),
                      // ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      InputField(
                        color: Theme.of(context).hintColor,
                        backgroundColor: Theme.of(context).primaryColorDark,
                        placeholderText: 'Email',
                        controller: _emailController,
                        validator: validateEmail,
                        errorTextList: emailErrorList,
                        errorCount: emailErrorDouble,
                      ),
                      const SizedBox(height: 20),
                      Button(
                        placeholderText: 'Submit',
                        backgroundColor: Theme.of(context).focusColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            sendForgotPassword();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Theme.of(context).focusColor,
      ),
    );
  }
}
