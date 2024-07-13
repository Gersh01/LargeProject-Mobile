import 'package:flutter/material.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> with SingleTickerProviderStateMixin {

  late TabController _tabController;


  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;


    BoxDecoration decoration = BoxDecoration(
      color: const Color(0xff6B7280),
      shape: BoxShape.rectangle,
      borderRadius: _tabController.index == 0 ? const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ) : const BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      )
    );


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Projects',

            style: TextStyle(

              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'League Spartan',
              color: Colors.black,
              shadows: [ Shadow(
                offset: Offset(0, 4.0),
                blurRadius: 20.0,
                color: Colors.white,
              ),]
            ),
          ),

          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _tabController.index = index;
              });
            },
            indicator: decoration,

            tabs: [
              SizedBox(
                width: width,
                child: const Tab(text: 'My Projects')
              ),
              SizedBox(
                width: width,
                child: const Tab(text: 'Joined Projects')
              ),
            ],
            labelColor: Colors.white,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Center(child: Text('My Projects')),
            Center(child: Text('Joined Projects')),
          ]
        )
      )
    );
  }
}