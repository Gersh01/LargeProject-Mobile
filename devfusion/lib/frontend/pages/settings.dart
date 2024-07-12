import 'dart:convert';

import 'package:devfusion/frontend/components/InputField.dart';
import 'package:devfusion/frontend/components/SizedButton.dart';
import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/pages/lander.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/Button.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final nameFormKey = GlobalKey<FormState>();

  SharedPref sharedPref = SharedPref();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  String firstName = "";
  String lastName = "";

  List<String>? firstNameErrorList;
  double firstNameErrorDouble = 0;
  List<String>? lastNameErrorList;
  double lastNameErrorDouble = 0;

  void getUserCredentials() async {
    String? token = await sharedPref.readToken();
    var reqBody = {"token": token};

    var response = await http.post(
      Uri.parse(jwtUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      print("settings jwt sucessful");
      var jsonResponse = jsonDecode(response.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
      setState(() {
        firstName = jsonResponse['firstName'];
        lastName = jsonResponse['lastName'];
        _firstNameController.text = jsonResponse['firstName'];
        _lastNameController.text = jsonResponse['lastName'];
      });
    } else {
      print("settings jwt unsucessful");
    }
  }

  void updateName() async {
    String? token = await sharedPref.readToken();
    var reqBody = {
      "token": token,
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text
    };

    var response = await http.put(
      Uri.parse(updateUserUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      print("settings update name sucessful");
      var jsonResponse = jsonDecode(response.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
      getUserCredentials();
    } else {
      print(
          "settings update name unsucessful. Status code: ${response.statusCode}");
    }
  }

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

  @override
  void initState() {
    getUserCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: 'League Spartan',
                color: Color.fromRGBO(124, 58, 237, 1),
                shadows: [
                  Shadow(
                    offset: Offset(0, 4.0),
                    blurRadius: 20.0,
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'League Spartan',
                      color: Color.fromRGBO(124, 58, 237, 1),
                      shadows: [
                        Shadow(
                          offset: Offset(0, 4.0),
                          blurRadius: 20.0,
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      ],
                    ),
                  ),
                ),
                Form(
                  key: nameFormKey,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: InputField(
                          placeholderText: 'First Name',
                          controller: _firstNameController,
                          validator: validateFirstName,
                          errorTextList: firstNameErrorList,
                          errorCount: firstNameErrorDouble,
                          hintText: firstName,
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
                          hintText: lastName,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Align(
                      alignment: Alignment.centerRight,
                      // padding: const EdgeInsets.only(left: 400),
                      child: SizedButton(
                        width: 150,
                        placeholderText: 'Save',
                        // backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
                        backgroundColor: const Color.fromRGBO(107, 114, 128, 1),
                        textColor: Colors.white,
                        onPressed: () async {
                          if (nameFormKey.currentState!.validate()) {
                            updateName();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Display Mode',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'League Spartan',
                      color: Color.fromRGBO(124, 58, 237, 1),
                      shadows: [
                        Shadow(
                          offset: Offset(0, 4.0),
                          blurRadius: 20.0,
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Color.fromRGBO(17, 24, 39, 1),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2.0),
                        blurRadius: 2.0,
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                      ),
                    ],
                  ),
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'League Spartan',
                      color: Color.fromRGBO(124, 58, 237, 1),
                      shadows: [
                        Shadow(
                          offset: Offset(0, 4.0),
                          blurRadius: 20.0,
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Align(
                  alignment: Alignment.centerRight,
                  // padding: const EdgeInsets.only(left: 400),
                  child: SizedButton(
                    width: 150,
                    placeholderText: 'Reset',
                    backgroundColor: const Color.fromRGBO(239, 68, 68, 1),
                    textColor: Colors.white,
                    onPressed: () async {},
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Button(
                  placeholderText: 'Logout',
                  // backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
                  backgroundColor: const Color.fromRGBO(239, 68, 68, 1),
                  textColor: Colors.white,
                  onPressed: () {
                    sharedPref.removeToken();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Lander()),
                    );
                  },
                ),
                Button(
                  placeholderText: 'About Us',
                  // backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
                  backgroundColor: const Color.fromRGBO(107, 114, 128, 1),
                  textColor: Colors.white,
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const AboutUs()),
                    // );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
