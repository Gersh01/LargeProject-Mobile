import 'dart:convert';

import 'package:devfusion/frontend/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'frontend/pages/home.dart';
import 'frontend/pages/lander.dart';
import 'frontend/pages/login_page.dart';
import 'frontend/pages/signup_page.dart';
import 'frontend/pages/profile.dart';
import 'package:http/http.dart' as http;
import 'frontend/pages/reset_password.dart';
import 'frontend/pages/update_password.dart';
import './themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //CHECK IF THE USER IS ALREADY SIGNED IN
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');
  bool isSignedIn = false;
  if (token != null) {
    var reqBody = {"token": token};

    var response = await http.post(
      Uri.parse(jwtUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      sharedPreferences.setString('token', jsonResponse['newToken']);
      isSignedIn = true;
    }
  }

  //RUN THE APP
  runApp(MyApp(
    isSignedIn: isSignedIn,
  ));
}

class MyApp extends StatelessWidget {
  final isSignedIn;

  const MyApp({@required this.isSignedIn, super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkMode,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      routes: {
        '/updatePassword': (context) => const UpdatePassword(),
        '/login': (context) => const LoginPage(),
        '/resetPassword': (context) => const ResetPassword(),
        '/lander': (context) => const Lander(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const Home(),
        '/profile': (context) => const Profile(),
      },
      // Set the inital rout to be /home if user is signed in, otherwise set it /lander
      initialRoute: (isSignedIn) ? '/home' : '/lander',
      // initialRoute: '/home',
    );
  }
}
