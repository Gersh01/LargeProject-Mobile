import 'dart:convert';

import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/pages/lander.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'create.dart';
import 'discover.dart';
import 'profile.dart';
import 'projects.dart';
import 'settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    print(_selectedIndex);
  }

  final List<Widget> _children = [
    const Discover(),
    const Create(),
    const Projects(),
    const Profile(),
    const Settings(),
  ];

  initHome() async {
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
      if (response.statusCode != 200) {
        print("test123");
        sharedPref.removeToken();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Lander()),
        );
      } else {
        var jsonResponse = jsonDecode(response.body);
        sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
      }
    } else {
      print("test456");
      sharedPref.removeToken();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Lander()),
      );
    }
    // });
  }

  @override
  void initState() {
    initHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initHome();
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(31, 41, 55, 1),
                icon: Icon(Icons.assistant_navigation),
                label: 'projects'),
            BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(31, 41, 55, 1),
                icon: Icon(Icons.add_to_queue_rounded),
                label: 'create'),
            BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(31, 41, 55, 1),
                icon: Icon(Icons.search),
                label: 'discover'),
            BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(31, 41, 55, 1),
                icon: Icon(Icons.circle),
                label: 'profile'),
            BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(31, 41, 55, 1),
                icon: Icon(Icons.settings),
                label: 'settings'),
          ]),
    );
  }
}
