import 'dart:convert';

import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../components/Button.dart';
import '../components/InputField.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool passwordVisible = true;
  bool passwordConfirmVisible = true;

  List<String>? passwordErrorList;
  double passwordErrorDouble = 0;
  List<String>? passwordConfirmErrorList;
  double passwordConfirmErrorDouble = 0;

  SharedPref sharedPref = SharedPref();

  String? validateConfirmPassword(String? value) {
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
    } else if (_passwordController.text != _confirmPasswordController.text) {
      errorsList.add('Passwords must match');
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
        passwordConfirmErrorList = ['Password is required'];
        passwordConfirmErrorDouble = 1;
      });
      return 'Password is required';
    } else if (!validPassword.hasMatch(value)) {
      setState(() {
        passwordConfirmErrorList = errorsList;
        passwordConfirmErrorDouble = counter;
      });
      return 'Password does not follow the correct format';
    } else {
      setState(() {
        passwordConfirmErrorList = null;
        passwordConfirmErrorDouble = 0;
      });
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        passwordErrorList = ['Password is required'];
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

  void updatePassword() async {
    String? token = await sharedPref.readToken();
    var reqBody = {"token": token, "newPassword": _passwordController.text};

    var response = await http.post(
      Uri.parse(resetPasswordUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("Reset password successful");
      setState(() {
        passwordConfirmErrorList = ["Password updated"];
        passwordConfirmErrorDouble = 1;
      });
    } else {
      print("Reset password unsucessful");
      setState(() {
        passwordConfirmErrorList = [jsonResponse["error"]];
        passwordConfirmErrorDouble = 1;
      });
    }
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
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
        body: Center(
          child: Container(
            height: 500,
            width: 370,
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                        'Reset Password',
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
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                      InputField(
                        placeholderText: 'Confirm Password',
                        isObscure: passwordConfirmVisible,
                        controller: _confirmPasswordController,
                        validator: validateConfirmPassword,
                        errorTextList: passwordConfirmErrorList,
                        errorCount: passwordConfirmErrorDouble,
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passwordConfirmVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passwordConfirmVisible = !passwordConfirmVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Button(
                        placeholderText: 'Submit',
                        backgroundColor: Theme.of(context).focusColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            updatePassword();
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
