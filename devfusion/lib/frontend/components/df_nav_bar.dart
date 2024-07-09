import 'package:flutter/material.dart';

class DfNavBar extends StatefulWidget{
  const DfNavBar({super.key});

  @override
  State<DfNavBar> createState() => _DfNavBarState();
}

class _DfNavBarState extends State<DfNavBar> {

  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });

    print(_selectedIndex);
  }

  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(backgroundColor: Color.fromRGBO(31, 41, 55, 1), icon: Icon(Icons.assistant_navigation), label: 'projects'),
          BottomNavigationBarItem(backgroundColor: Color.fromRGBO(31, 41, 55, 1), icon: Icon(Icons.add_to_queue_rounded), label:'create'),
          BottomNavigationBarItem(backgroundColor: Color.fromRGBO(31, 41, 55, 1), icon: Icon(Icons.search), label:'discover'),
          BottomNavigationBarItem(backgroundColor: Color.fromRGBO(31, 41, 55, 1), icon: Icon(Icons.circle), label:'profile'),
        ]
      );
  }
}