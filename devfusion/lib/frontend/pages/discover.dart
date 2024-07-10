import 'package:flutter/material.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  String _dropdownValue = 'recent';

  void dropdownCallback(String? newValue) {
    if (newValue != null) {
      setState(() {
        _dropdownValue = newValue;
      });
    }
  }

  String _dropdownSearchByValue = 'Title';

  void dropdownSearchByCallback(String? newValue) {
    if (newValue != null) {
      setState(() {
        _dropdownSearchByValue = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Discover',
            style: TextStyle(
                
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'League Spartan',
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(0, 4.0),
                    blurRadius: 20.0,
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ]),
          ),
          backgroundColor: const Color.fromRGBO(31, 41, 55, 1),
        ),
        body: Column(
          children: [
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                
                  child: DropdownButton(
                    isDense: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'Title',
                        child: Text('Title'),
                      ),
                      DropdownMenuItem(
                        value: 'Technology',
                        child: Text('Technology'),
                      ),
                      DropdownMenuItem(
                        value: 'Description',
                        child: Text('Description'),
                      ),
                      DropdownMenuItem(
                        value: 'Role',
                        child: Text('Role'),
                      )
                    ],
                    value: _dropdownSearchByValue,
                    onChanged: dropdownSearchByCallback,
                  ),
              ),
              ),
  
              //Search Bar
              const Expanded(
                
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                
              ),
            ]),

            //Search By Dropdown

            Align(
                alignment: Alignment.centerRight,
                child: DropdownButton(items: const [
                DropdownMenuItem(
                  value: 'recent',
                  child: Text('Most Recent'),
                ),
                DropdownMenuItem(
                  value: 'relevance',
                  child: Text('Relevance'),
                )
              ], value: _dropdownValue, onChanged: dropdownCallback),
            ),

            //Project Cards
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text('Project $index'),
                      subtitle: const Text('Project Description'),
                      trailing: const Icon(Icons.more_vert),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
