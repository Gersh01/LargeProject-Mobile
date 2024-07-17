import 'dart:convert';
import 'dart:developer';

import 'package:devfusion/frontend/components/joined_projects_tile.dart';
// import 'package:devfusion/frontend/components/project_tile.dart';
import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/json/Project.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/my_projects_tile.dart';
import '../json/Profile.dart';
import 'view_project.dart';

class Projects extends StatefulWidget {
  final String? userId;
  const Projects({super.key, this.userId});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController ownedProjectsScrollController;
  late ScrollController joinedProjectsScrollController;

  List<Project> ownedProjects = [];
  List<Project> joinedProjects = [];
  bool loading = true;
  bool isRetrievingOwnedProjects = false;
  bool isRetrievingJoinedProjects = false;
  bool endOfOwnedProject = false;
  bool endOfJoinedProject = false;

  late Profile? userProfile = null;

  String username = "";

  @override
  void initState() {
    super.initState();

    // fetchProjects(true);
    fetchUser();
    fetchOwnedProjects(true);
    fetchJoinedProjects(true);
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    ownedProjectsScrollController = ScrollController()..addListener(onScroll);
    joinedProjectsScrollController = ScrollController()..addListener(onScroll);
  }

  @override
  void dispose() {
    ownedProjectsScrollController.removeListener(onScroll);
    joinedProjectsScrollController.removeListener(onScroll);
    super.dispose();
  }

  void onScroll() {
    if (!ownedProjectsScrollController.hasClients ||
        !joinedProjectsScrollController.hasClients) {
      return;
    }
    // Detect owned project scroll position
    if (_tabController.index == 0 &&
        ownedProjectsScrollController.position.extentAfter < 500) {
      if (!isRetrievingOwnedProjects && !loading && !endOfOwnedProject) {
        fetchOwnedProjects(false);
      }
    } else {
      // Detect joined project scroll position
      if (joinedProjectsScrollController.position.extentAfter < 500) {
        if (!isRetrievingJoinedProjects && !loading && !endOfJoinedProject) {
          fetchJoinedProjects(false);
        }
      }
    }
  }

  Future fetchUser() async {
    SharedPref sharedPref = SharedPref();

    var token = await sharedPref.readToken();

    var reqBodyUser = {"token": token};

    var userResponse = await http.post(
      Uri.parse(jwtUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBodyUser),
    );

    if (userResponse.statusCode == 200) {
      var jsonResponse = jsonDecode(userResponse.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
      setState(() {
        userProfile = Profile.fromJson(jsonResponse);
        username = userProfile!.username;
      });
    } else {
      print("settings jwt unsucessful");
    }
  }

  Future fetchOwnedProjects(bool initial) async {
    SharedPref sharedPref = SharedPref();

    var token = await sharedPref.readToken();

    var reqBody = {
      "token": token,
      "searchBy": "title",
      "sortBy": "recent",
      "query": "",
      "count": initial ? 8 : 4,
      "initial": initial,

      // cursor
      "projectId": initial
          ? "000000000000000000000000"
          : ownedProjects[ownedProjects.length - 1].id
    };

    setState(() {
      isRetrievingOwnedProjects = true;
    });
    var response = await http.post(
      Uri.parse(ownedProjectsUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);

      var projectsData = jsonResponse['results'];

      List<Project> retrievedProjects = [];

      for (int i = 0; i < projectsData.length; i++) {
        retrievedProjects.add(Project.fromJson(projectsData[i]));
      }

      // Set endOfProjects to true if reach the end
      if (retrievedProjects.isEmpty) {
        setState(() {
          endOfOwnedProject = true;
        });
      }

      setState(() {
        loading = false;
        ownedProjects = [...ownedProjects, ...retrievedProjects];
        isRetrievingOwnedProjects = false;
      });
    } else {
      // String jsonDataString = response.body.toString();
      // var _data = jsonDecode(jsonDataString);
      return Future.value("Failed to fetch projects");
    }
  }

  Future fetchJoinedProjects(bool initial) async {
    SharedPref sharedPref = SharedPref();

    var token = await sharedPref.readToken();

    var reqBody = {
      "token": token,
      "searchBy": "title",
      "sortBy": "recent",
      "query": "",
      "count": initial ? 8 : 4,
      "initial": initial,

      // cursor
      "projectId": initial
          ? "000000000000000000000000"
          : joinedProjects[joinedProjects.length - 1].id
    };

    setState(() {
      isRetrievingJoinedProjects = true;
    });
    var response = await http.post(
      Uri.parse(joinedProjectsUrl),
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
          endOfJoinedProject = true;
        });
      }

      List<Project> retrievedProjects = [];

      for (int i = 0; i < projectsData.length; i++) {
        retrievedProjects.add(Project.fromJson(projectsData[i]));
      }
      setState(() {
        loading = false;
        joinedProjects = [...joinedProjects, ...retrievedProjects];
        isRetrievingJoinedProjects = false;
      });
    } else {
      // String jsonDataString = response.body.toString();
      // var _data = jsonDecode(jsonDataString);
      return Future.value("Failed to fetch projects");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;

    BoxDecoration decoration = BoxDecoration(
      //This is the color selector
      color: Theme.of(context).primaryColorDark,
      shape: BoxShape.rectangle,
      borderRadius: _tabController.index == 0
          ? const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            )
          : const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Projects',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'League Spartan',
              color: Theme.of(context).hintColor,
            ),
          ),
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _tabController.index = index;
              });
            },
            //The unselected text color
            unselectedLabelColor: Colors.white,
            indicator: decoration,
            dividerColor: Colors.grey,
            tabs: [
              SizedBox(
                  width: width,
                  child: const Tab(
                    text: 'My Projects',
                  )),
              SizedBox(width: width, child: const Tab(text: 'Joined Projects')),
            ],
            //Changes the color of the text
            labelColor: Colors.white,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              controller: ownedProjectsScrollController,
              itemCount: ownedProjects.length,
              itemBuilder: (BuildContext context, int index) {
                var project = ownedProjects[index];
                return InkWell(
                  child: MyProjectsTile(project: project),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewProject(
                          project: project,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            ListView.builder(
              controller: joinedProjectsScrollController,
              itemCount: joinedProjects.length,
              itemBuilder: (BuildContext context, int index) {
                var project = joinedProjects[index];
                return InkWell(
                  child:
                      JoinedProjectsTile(project: project, username: username),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewProject(
                          project: project,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
