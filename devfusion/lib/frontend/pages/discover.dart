import 'dart:async';
import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/json/Project.dart';
import 'package:flutter/material.dart';
import '../components/project_tile.dart';
import '../utils/utility.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/Divider.dart';
import '../pages/view_project.dart';

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

    var reqBody = {
      "token": token,

      "searchBy": _dropdownSearchByValue,
      "sortBy": _dropdownSortByValue,

      "query": _query,

      "count": initial ? 8 : 4,
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

      List<Project> retrievedProjects = [];

      for (int i = 0; i < projectsData.length; i++) {
        retrievedProjects.add(
          Project.fromJson(projectsData[i]),
        );
      }

      setState(() {
        projects = [...projects, ...retrievedProjects];
        loading = false;
        isRetrievingProjects = false;
      });
    } else {
      // String jsonDataString = response.body.toString();
      // var _data = jsonDecode(jsonDataString);
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
      backgroundColor: Theme.of(context).primaryColor,
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
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).dialogBackgroundColor),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: DropdownButton(
                                underline: Container(
                                  height: 0,
                                ),
                                focusColor:
                                    Theme.of(context).dialogBackgroundColor,
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
                                isExpanded: true,
                                value: _dropdownSearchByValue,
                                onChanged: dropdownSearchByCallback,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Search Bar
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: TextFormField(
                          onChanged: (text) {
                            setState(() {
                              _query = text;
                              projects.clear();
                              fetchProjects(true);
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                            ),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.search),
                            ),
                            filled: false,
                            fillColor: Theme.of(context).primaryColorLight,
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: SizedBox(
                        height: 35,
                        width: 5,
                        child: Container(
                          decoration:
                              BoxDecoration(color: Theme.of(context).hintColor),
                        ),
                      ),
                    )
                  ],
                ),

                //Search By Dropdown

                Align(
                  alignment: Alignment.centerRight,
                  child: DropdownButton(
                      underline: Container(
                        height: 0,
                      ),
                      dropdownColor: Theme.of(context).primaryColorLight,
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
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: DividerLine(),
                ),
                //Project Cards
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: projects.length,
                      itemBuilder: (BuildContext context, int index) {
                        var project = projects[index];
                        return InkWell(
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ProjectTile(project: project),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewProject(
                                  project: project,
                                ),
                              ),
                            ).then(
                              (val) {
                                if (val == "delete") {
                                  setState(() {
                                    projects = [];
                                  });
                                  fetchProjects(true);
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
