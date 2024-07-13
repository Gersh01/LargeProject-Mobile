import 'dart:convert';

import 'package:devfusion/frontend/utils/utility.dart';
import 'package:flutter/material.dart';

import '../components/Button.dart';
import '../components/InputField.dart';

import 'package:http/http.dart' as http;

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
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
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
            decoration: const BoxDecoration(
              color: Color.fromRGBO(31, 41, 55, 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 90,
                      ),
                      // Center(
                      Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'League Spartan',
                          color: Colors.white,
                        ),
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
                        placeholderText: 'Email',
                        controller: _emailController,
                        validator: validateEmail,
                        errorTextList: emailErrorList,
                        errorCount: emailErrorDouble,
                      ),
                      const SizedBox(height: 20),
                      Button(
                        placeholderText: 'Submit',
                        backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
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
        backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
      ),
    );
  }
}