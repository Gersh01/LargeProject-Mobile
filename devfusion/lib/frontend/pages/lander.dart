import 'dart:convert';

import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/pages/home.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/Button.dart';

class Lander extends StatelessWidget {
  const Lander({super.key});

  initLogin(context) async {
    SharedPref sharedPref = SharedPref();
    String? token = await sharedPref.readToken();
    // Future.delayed(const Duration(seconds: 2), () async {
    if (token != null) {
      var reqBody = {"token": token};

      var response = await http.post(
        Uri.parse(jwtUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }
    }
    // });
  }

  @override
  Widget build(BuildContext context) {
    initLogin(context);
    return MaterialApp(
        home: Scaffold(
            backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
            body: Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, top: 150.0, bottom: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                        child: Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 32,
                            ),
                            "THRIVE IN THE POWER OF OPEN-SOURCE TO DRIVE INNOVATION!")),
                    const SizedBox(height: 15),
                    const Center(
                        child: Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                            "Whether you're a seasoned developer or just starting out, you'll find a place here")),
                    const SizedBox(height: 15),
                    const Center(
                        child: Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                            "connect with like-minded individuals who share your passion for coding")),
                    const SizedBox(height: 50),
                    const Center(
                        child: Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                            "Together, we can build a brighter future, one line of code at a time!")),
                    Expanded(
                        child: Container(
                      color: const Color.fromRGBO(124, 58, 237, 1),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Button(
                          placeholderText: "Get Started",
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          }),
                    )
                  ],
                ))));
  }
}
