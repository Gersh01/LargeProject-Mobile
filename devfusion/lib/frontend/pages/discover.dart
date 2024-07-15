import 'dart:async';
import 'dart:ffi';

import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/json/Project.dart';
import 'package:devfusion/frontend/pages/projects_page.dart';
import 'package:flutter/material.dart';
import '../../themes/theme.dart';
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
  late ScrollController scrollController;

  void dropdownSortByCallback(String? newValue) {
    if (newValue != null) {
      setState(() {
        _dropdownSortByValue = newValue;
        projects.clear();
        fetchProjects(true);
      });
    }
  }

  String _dropdownSearchByValue = 'title';

  void dropdownSearchByCallback(String? newValue) {
    if (newValue != null) {
      setState(() {
        _dropdownSearchByValue = newValue;
        projects.clear();
        fetchProjects(true);
      });
    }
  }

  String _query = '';

  TextEditingController queryController = TextEditingController();

  List<Project> projects = [];
  bool loading = true;
  bool isRetrievingProjects = true;
  bool endOfProject = false;

  // fetch all projects
  Future fetchProjects(bool initial) async {
    SharedPref sharedPref = SharedPref();

    setState(() {
      isRetrievingProjects = true;
    });

    var token = await sharedPref.readToken();

    print("Fetching projects WITH A QUERY OF: $_query");
    print("Fetching projects WITH A SEARCH BY OF: $_dropdownSearchByValue");
    print("Fetching projects WITH A SORT BY OF: $_dropdownSortByValue");

    var reqBody = {
      "token": token,

      "searchBy": _dropdownSearchByValue,
      "sortBy": _dropdownSortByValue,

      "query": _query,

      "count": 4,
      "initial": initial,

      // cursor
      "projectId": initial
          ? "000000000000000000000000"
          : projects[projects.length - 1].id,
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

      // Set endOfProjects to true if reach the end
      if (projectsData.length == 0) {
        setState(() {
          endOfProject = true;
        });
      }

      for (int i = 0; i < projectsData.length; i++) {
        projects.add(Project.fromJson(projectsData[i]));
      }
      setState(() {
        loading = false;
        isRetrievingProjects = false;
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
    fetchProjects(true);
    scrollController = ScrollController()..addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    super.dispose();
  }

  void onScroll() {
    if (scrollController.position.extentAfter < 500) {
      if (!isRetrievingProjects && !loading && !endOfProject) {
        fetchProjects(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'League Spartan',
            color: Theme.of(context).hintColor,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Theme.of(context).primaryColorLight,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: DropdownButton(
                              isDense: true,
                              items: const [
                                DropdownMenuItem(
                                  value: 'title',
                                  child: Text('Title'),
                                ),
                                DropdownMenuItem(
                                  value: 'technologies',
                                  child: Text('Technologies'),
                                ),
                                DropdownMenuItem(
                                  value: 'description',
                                  child: Text('Description'),
                                ),
                                DropdownMenuItem(
                                  value: 'roles',
                                  child: Text('Roles'),
                                )
                              ],
                              value: _dropdownSearchByValue,
                              onChanged: dropdownSearchByCallback,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                        width: 10,
                        height: 40,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        )),

                    //Search Bar
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: TextField(
                          onChanged: (text) {
                            print("TEXT: $text");
                            setState(() {
                              print(
                                  "PROJECTS LENGTH BEFORE:  ${projects.length}");
                              projects.clear();
                              print(
                                  "PROJECTS LENGTH AFTER:  ${projects.length}");
                              _query = text;
                              fetchProjects(true);
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                            ),
                            prefixIcon: Icon(Icons.search),
                            filled: true,
                            fillColor: Theme.of(context).primaryColorLight,
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

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
                      onChanged: dropdownSortByCallback),
                ),

                //Project Cards
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: projects.length,
                    itemBuilder: (BuildContext context, int index) {
                      var project = projects[index];
                      return ProjectTile(project: project);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
