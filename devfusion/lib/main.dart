import 'package:flutter/material.dart';
import 'frontend/pages/lander.dart';
import 'frontend/pages/login_page.dart';
import 'frontend/pages/reset_password.dart';
import 'frontend/pages/update_password.dart';

void main() {
  runApp( const MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      routes: {
        '/updatePassword': (context) => const UpdatePassword(),
        '/login': (context) => const LoginPage(),
        '/resetPassword': (context) => const ResetPassword(),
        '/lander': (context) => const Lander(),
      },
      initialRoute: '/lander',
    );
  }
}



