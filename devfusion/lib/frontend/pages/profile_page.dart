import 'dart:convert';
import 'dart:developer';

import 'package:devfusion/frontend/components/profile/bio_fields.dart';
import 'package:devfusion/frontend/components/profile/technologies_field.dart';
import 'package:devfusion/frontend/components/project_tile.dart';
import 'package:devfusion/frontend/json/Project.dart';
import 'package:devfusion/frontend/pages/view_project.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:flutter/material.dart';
import '../components/profile_pictures.dart';
import '../json/Profile.dart';
import 'package:http/http.dart' as http;
import '../components/Divider.dart';

class ProfilePage extends StatefulWidget {
  final String? urlExtension;
  final String? userId;

  const ProfilePage({super.key, this.urlExtension, this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPref sharedPref = SharedPref();
  late Profile? userProfile = null;
  bool profile = true;
  bool loading = true;
  bool projectLoading = true;

  late ScrollController scrollController;
  List<Project> profileProjects = [];
  bool isRetrievingProjects = true;
  bool endOfProject = false;

  Future getTheirUserInfo() async {
    String? token = await sharedPref.readToken();
    var reqBody = {"token": token};

    var response = await http.post(
      Uri.parse("$getUserUrl${widget.userId}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        userProfile = Profile.fromJson(jsonResponse);
        loading = false;
      });
    } else {
      log("Getting users profile failed");
    }
  }

  Future getUserInfo() async {
    String? token = await sharedPref.readToken();
    var reqBody = {"token": token};

    var response = await http.post(
      Uri.parse(jwtUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
      setState(() {
        userProfile = Profile.fromJson(jsonResponse);
        loading = false;
      });
    } else {
      log("settings jwt unsucessful");
    }
  }

  Future fetchUserProjects(bool initial) async {
    SharedPref sharedPref = SharedPref();
    // var reqBody;
    var token = await sharedPref.readToken();

    var reqBody = {
      "token": token,
      "searchBy": "title",
      "sortBy": "recent",
      "query": "",
      "count": initial ? 8 : 4,
      "initial": initial,
      "userId": widget.userId == null
          ? userProfile?.userId ?? ""
          : widget.userId ?? "",

      // cursor
      "projectId": initial
          ? "000000000000000000000000"
          : profileProjects[profileProjects.length - 1].id
    };

    setState(() {
      isRetrievingProjects = true;
    });
    var response = await http.post(
      Uri.parse(ownedJoinedUrl),
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
          endOfProject = true;
        });
      }

      setState(() {
        projectLoading = false;
        profileProjects = [...profileProjects, ...retrievedProjects];
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentRoute = ModalRoute.of(context)?.settings.name;
      if (currentRoute != null) {
        final uri = Uri.parse(currentRoute);
        final id = uri.queryParameters['id'];
        log("The current uri = " + uri.toString());
        if (id != null) {
          log("The current ID = " + id);
        }
      }
    });
    if (widget.userId == null) {
      getUserInfo();
    } else {
      profile = false;
      getTheirUserInfo();
    }
    scrollController = ScrollController()..addListener(onScroll);
    fetchUserProjects(true);
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    super.dispose();
  }

  void onScroll() {
    if (scrollController.position.extentAfter < 500) {
      if (!isRetrievingProjects && !projectLoading && !endOfProject) {
        fetchUserProjects(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'League Spartan',
            color: Theme.of(context).hintColor,
            // color: Theme.of(context).white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: projectLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        controller: scrollController,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: DividerLine(),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ProfilePictures(
                      imageUrl: userProfile?.link ?? "",
                    ),
                  ),
                  Text(
                    userProfile?.username ?? "",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'League Spartan',
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ]),
          ),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BioFields(
                    myProfile: profile,
                    bioMessage: userProfile?.bio ?? "",
                    userProfile: userProfile,
                  )
                ],
              )),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TechnologiesField(
                    myProfile: profile,
                    technologies: userProfile?.technologies ?? [],
                    userInfo: userProfile,
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
            child: Text(
              "Projects",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'League Spartan',
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Column(
              children: profileProjects.map((project) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    child: ProjectTile(project: project),
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
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
