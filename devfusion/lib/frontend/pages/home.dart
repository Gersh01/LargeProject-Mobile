import 'dart:convert';

import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/pages/lander.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:devfusion/themes/theme_provider.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'discover.dart';
import 'profile_page.dart';
import 'projects_page.dart';
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
    const Projects(),
    const ProfilePage(),
    const Settings(),
  ];

  initHome() async {
    SharedPref sharedPref = SharedPref();
    String? token = await sharedPref.readToken();
    // Future.delayed(const Duration(seconds: 2), () async {
    bool? isInDarkMode = await sharedPref.readDarkMode();
    if (isInDarkMode != null) {
      Provider.of<ThemeProvider>(context, listen: false)
          .toggleTheme(isInDarkMode);
    }
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
          backgroundColor: Theme.of(context).primaryColor,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(
                    color: Theme.of(context).hintColor,
                    Icons.image_search_outlined),
                label: 'Discover'),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(
                    color: Theme.of(context).hintColor, Icons.folder_outlined),
                label: 'Projects'),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(
                    color: Theme.of(context).hintColor, Icons.person_outlined),
                label: 'Profile'),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(
                    color: Theme.of(context).hintColor,
                    Icons.settings_outlined),
                label: 'Settings'),
          ]),
    );
  }
}
