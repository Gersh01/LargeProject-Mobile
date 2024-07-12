import 'dart:ffi';

import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/json/Project.dart';
import 'package:devfusion/frontend/pages/projects.dart';
import 'package:flutter/material.dart';
import '../components/project_tile.dart';
import '../utils/utility.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  String _dropdownSortByValue = 'recent';

  void dropdownCallback(String? newValue) {
    if (newValue != null) {
      setState(() {
        _dropdownSortByValue = newValue;
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

  TextEditingController queryController = TextEditingController();

  List<Project> projects = [];
  bool loading = true;

  // List<Project> projectsObjs = [];

  // fetch all projects
  Future fetchProjects() async {
    // fetch projects
    SharedPref sharedPref = SharedPref();

    var token = await sharedPref.readToken();

    var reqBody = {
      "token": token,

      "searchBy": _dropdownSearchByValue,
      "sortBy": _dropdownSortByValue,
      "query": queryController.text,
      "count": 4,
      "initial": true,

      // cursor
      "projectId": "000000000000000000000000"
    };

    var response = await http.post(
      Uri.parse(discoverUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);

      var projectsData = jsonResponse['results'];

      for (int i = 0; i < projectsData.length; i++) {
        // projects.add({
        //   "title": projectsData[i]['title'],
        //   "description": projectsData[i]['description'],
        //   "technologies": projectsData[i]['technologies']
        // });
        projects.add(Project.fromJson(projectsData[i]));
      }

      setState(() {
        loading = false;
      });
    } else {
      String jsonDataString = response.body.toString();
      var _data = jsonDecode(jsonDataString);
      return Future.value("Failed to fetch projects");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProjects();
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
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: queryController,
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                            prefixIcon: Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                    child: DropdownButton(
                        items: const [
                          DropdownMenuItem(
                            value: 'recent',
                            child: Text('Most Recent'),
                          ),
                          DropdownMenuItem(
                            value: 'relevance',
                            child: Text('Relevance'),
                          )
                        ],
                        value: _dropdownSortByValue,
                        onChanged: dropdownCallback),
                  ),

                  //Project Cards
                  Expanded(
                    child: ListView.builder(
                      itemCount: projects.length,
                      itemBuilder: (BuildContext context, int index) {
                        var project = projects[index];
                        return ProjectTile(
                          title: project.title,
                          description: project.description,
                          // technologies: project['technologies'],
                        );
                      },
                    ),
                  ),
                ],
              ));
  }
}
