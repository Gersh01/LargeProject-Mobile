import 'dart:convert';

import 'package:devfusion/frontend/components/project_tile.dart';
import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/json/Project.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Projects extends StatefulWidget {
  const Projects({super.key});

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
  bool isRetrievingOwnedProjects = true;
  bool isRetrievingJoinedProjects = true;
  bool endOfOwnedProject = false;
  bool endOfJoinedProject = false;

  @override
  void initState() {
    super.initState();

    fetchProjects(true);
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
    // Detect owned project scroll position
    if (_tabController.index == 0 &&
        ownedProjectsScrollController.position.extentAfter < 500) {
      if (!isRetrievingOwnedProjects && !loading && !endOfOwnedProject) {
        print("FETCHING OWNED");
        fetchProjects(false);
      }
    } else {
      // Detect joined project scroll position
      if (joinedProjectsScrollController.position.extentAfter < 500) {
        if (!isRetrievingJoinedProjects && !loading && !endOfJoinedProject) {
          print("FETCHING JOINED");
          fetchProjects(false);
        }
      }
    }
  }

  // fetch all projects
  Future fetchProjects(bool initial) async {
    SharedPref sharedPref = SharedPref();

    setState(() {
      isRetrievingOwnedProjects = true;
      isRetrievingJoinedProjects = true;
    });

    var token = await sharedPref.readToken();

    var reqBody = {
      "token": token,

      "searchBy": "title",
      "sortBy": "relevance",
      "query": "",
      "count": 4,
      "initial": initial,

      // cursor
      "projectId": initial
          ? "000000000000000000000000"
          : (_tabController.index == 0
              ? ownedProjects[ownedProjects.length - 1].id
              : joinedProjects[joinedProjects.length - 1].id),
    };

    var ownedProjectsResponse;
    var joinedProjectsResponse;

    if (initial) {
      ownedProjectsResponse = await http.post(
        Uri.parse(ownedProjectsUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      joinedProjectsResponse = await http.post(
        Uri.parse(joinedProjectsUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
    } else {
      if (_tabController.index == 0) {
        ownedProjectsResponse = await http.post(
          Uri.parse(ownedProjectsUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody),
        );
      } else {
        joinedProjectsResponse = await http.post(
          Uri.parse(joinedProjectsResponse),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody),
        );
      }
    }

    // Parsing retrieved owned projects
    if (ownedProjectsResponse.statusCode == 200) {
      var jsonResponse = jsonDecode(ownedProjectsResponse.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);

      var projectsData = jsonResponse['results'];

      // Set endOfProjects to true if reach the end
      if (projectsData.length == 0) {
        setState(() {
          endOfOwnedProject = true;
        });
      }

      for (int i = 0; i < projectsData.length; i++) {
        ownedProjects.add(Project.fromJson(projectsData[i]));
      }
    } else {
      String jsonDataString = ownedProjectsResponse.body.toString();
      var _data = jsonDecode(jsonDataString);
      return Future.value("Failed to fetch projects");
    }

    // Parsing retrieved joined projects
    if (joinedProjectsResponse.statusCode == 200) {
      var jsonResponse = jsonDecode(joinedProjectsResponse.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);

      var projectsData = jsonResponse['results'];

      // Set endOfProjects to true if reach the end
      if (projectsData.length == 0) {
        setState(() {
          endOfJoinedProject = true;
        });
      }

      for (int i = 0; i < projectsData.length; i++) {
        joinedProjects.add(Project.fromJson(projectsData[i]));
      }
    } else {
      String jsonDataString = joinedProjectsResponse.body.toString();
      var _data = jsonDecode(jsonDataString);
      return Future.value("Failed to fetch projects");
    }

    setState(() {
      loading = false;
      isRetrievingOwnedProjects = false;
      isRetrievingJoinedProjects = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;

    BoxDecoration decoration = BoxDecoration(
      color: const Color(0xff6B7280),
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
        appBar: AppBar(
          title: const Text(
            'Projects',
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'League Spartan',
                color: Colors.black,
                shadows: [
                  Shadow(
                    offset: Offset(0, 4.0),
                    blurRadius: 20.0,
                    color: Colors.white,
                  ),
                ]),
          ),
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _tabController.index = index;
              });
            },
            indicator: decoration,
            tabs: [
              SizedBox(width: width, child: const Tab(text: 'My Projects')),
              SizedBox(width: width, child: const Tab(text: 'Joined Projects')),
            ],
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
                return ProjectTile(
                  title: project.title,
                  description: project.description,
                );
              },
            ),
            ListView.builder(
              controller: joinedProjectsScrollController,
              itemCount: joinedProjects.length,
              itemBuilder: (BuildContext context, int index) {
                var project = joinedProjects[index];
                return ProjectTile(
                  title: project.title,
                  description: project.description,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
