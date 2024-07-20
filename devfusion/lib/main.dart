import 'dart:convert';

import 'package:devfusion/frontend/pages/about-us-page.dart';
import 'package:devfusion/frontend/pages/members_page.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:devfusion/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'frontend/pages/home.dart';
import 'frontend/pages/lander.dart';
import 'frontend/pages/login_page.dart';
import 'frontend/pages/signup_page.dart';
import 'frontend/pages/profile_page.dart';
import 'frontend/pages/members_page.dart';
import 'package:http/http.dart' as http;
import 'frontend/pages/forgot_password.dart';
import 'frontend/pages/reset_password.dart';
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
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(
        isSignedIn: isSignedIn,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final isSignedIn;

  const MyApp({@required this.isSignedIn, super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: (Provider.of<ThemeProvider>(context).themeData == null)
          ? lightMode
          : Provider.of<ThemeProvider>(context).themeData,
      darkTheme: (Provider.of<ThemeProvider>(context).themeData == null)
          ? darkMode
          : Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      routes: {
        '/forgotPassword': (context) => const ForgotPassword(),
        '/login': (context) => const LoginPage(),
        '/resetPassword': (context) => const ResetPassword(),
        '/lander': (context) => const Lander(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const Home(),
        '/profile': (context) => const ProfilePage(),
        '/aboutUs': (context) => const AboutUs(),
      },
      // Set the inital rout to be /home if user is signed in, otherwise set it /lander
      initialRoute: (isSignedIn) ? '/home' : '/lander',
      // initialRoute: '/home',
    );
  }
}
