import 'package:flutter/material.dart';

class DfNavBar extends StatelessWidget{
  const DfNavBar({super.key});

  @override
  Widget build(BuildContext context){
    return Center(
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(backgroundColor: Color.fromRGBO(31, 41, 55, 1), icon: Icon(Icons.assistant_navigation), label: 'projects'),
          BottomNavigationBarItem(backgroundColor: Color.fromRGBO(31, 41, 55, 1), icon: Icon(Icons.add_to_queue_rounded), label:'create'),
          BottomNavigationBarItem(backgroundColor: Color.fromRGBO(31, 41, 55, 1), icon: Icon(Icons.search), label:'discover'),
          BottomNavigationBarItem(backgroundColor: Color.fromRGBO(31, 41, 55, 1), icon: Icon(Icons.circle), label:'profile'),
        ]
      )
    );
  }
}