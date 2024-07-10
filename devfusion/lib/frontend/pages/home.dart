import 'package:flutter/material.dart';

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

  void _onItemTapped(int index){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _children[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(backgroundColor: Color.fromRGBO(31, 41, 55, 1), icon: Icon(Icons.assistant_navigation), label: 'projects'),
          BottomNavigationBarItem(backgroundColor: Color.fromRGBO(31, 41, 55, 1), icon: Icon(Icons.add_to_queue_rounded), label:'create'),
          BottomNavigationBarItem(backgroundColor: Color.fromRGBO(31, 41, 55, 1), icon: Icon(Icons.search), label:'discover'),
          BottomNavigationBarItem(backgroundColor: Color.fromRGBO(31, 41, 55, 1), icon: Icon(Icons.circle), label:'profile'),
          BottomNavigationBarItem(backgroundColor: Color.fromRGBO(31, 41, 55, 1), icon: Icon(Icons.settings), label:'settings'),
        ]
      ),
    );
  }
}