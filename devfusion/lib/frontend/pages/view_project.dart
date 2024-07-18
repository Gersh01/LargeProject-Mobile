import 'dart:developer';
import 'package:devfusion/frontend/components/bubbles/communication_bubble.dart';
import 'package:devfusion/frontend/components/modals/apply_modal.dart';
import 'package:devfusion/frontend/components/modals/confirm_cancel_modal.dart';
import 'package:devfusion/frontend/components/small_button.dart';
import 'package:devfusion/frontend/json/Profile.dart';
import 'package:devfusion/frontend/pages/application_page.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:devfusion/themes/theme.dart';
import 'package:flutter/material.dart';
import '../components/manage_team/members_per_role.dart';
import '../components/bubbles/tech_bubble.dart';
import '../json/Project.dart';
import '../json/team_member.dart';
import '../pages/members_page.dart';
import '../components/manage_team/role_bubbles.dart';
import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum VisitorType {
  visitor,
  member,
  owner,
  projectManager,
}

class ViewProject extends StatefulWidget {
  final Project project;

  const ViewProject({super.key, required this.project});

  @override
  State<ViewProject> createState() => _ViewProjectState();
}

class _ViewProjectState extends State<ViewProject> {
  late List<MembersPerRole> roleInfo;
  late List<TeamMember> teamMembers;
  Profile? userProfile;
  bool loading = true;
  VisitorType? visitorType;
  List<Widget> controls = [];
  String? roleToApply;
  late Project project;

  void getMembersPerRole() {
    roleInfo = [];
    for (int i = 0; i < project.roles.length; i++) {
      teamMembers = [];
      for (int j = 0; j < project.teamMembers.length; j++) {
        if (project.roles[i].role == project.teamMembers[j].role) {
          teamMembers.add(project.teamMembers[j]);
        }
      }
      roleInfo.add(
        MembersPerRole(project.roles[i].role, project.roles[i].count,
            project.roles[i].description, teamMembers),
      );
    }
  }

  Future retrieveProject() async {
    SharedPref sharedPref = SharedPref();
    String? token = await sharedPref.readToken();
    var reqBody = {
      "token": token,
    };
    var request = http.Request(
      'GET',
      Uri.parse("$getProjectUrl${project.id}"),
    )..headers.addAll(
        {"Content-Type": "application/json"},
      );

    request.body = jsonEncode(reqBody);
    var response = await request.send();

    if (response.statusCode == 200) {
      var projectData = await response.stream.bytesToString();

      setState(
        () {
          project = Project.fromJson(
            jsonDecode(projectData)['project'],
          );
        },
      );
      getMembersPerRole();
      getVisitorType();
    }
  }

  void beginProject() async {
    SharedPref sharedPref = SharedPref();
    String? token = await sharedPref.readToken();
    var reqBody = {
      "token": token,
      "projectId": project.id,
      "title": project.title,
      "projectStartDate": DateTime.now().toString(),
      "deadline": project.deadline.toString(),
      "description": project.description,
      "isStarted": true,
      "roles": project.roles.map((role) => role.toJson()).toList(),
      "technologies": project.technologies,
      "communications":
          project.communications.map((comm) => comm.toJson()).toList(),
    };

    var response = await http.put(
      Uri.parse(editProjectUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
      retrieveProject();
    } else {
      log("settings jwt unsucessful");
    }
  }

  void leaveProject() async {
    SharedPref sharedPref = SharedPref();
    String? token = await sharedPref.readToken();
    var reqBody = {
      "token": token,
      "projectId": project.id,
    };

    var response = await http.post(
      Uri.parse(leaveProjectUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      retrieveProject();
    } else {
      log(response.statusCode.toString());
    }
  }

  void deleteProject() async {
    SharedPref sharedPref = SharedPref();
    String? token = await sharedPref.readToken();
    var reqBody = {
      "token": token,
    };

    var response = await http.delete(
      Uri.parse("$deleteProjectUrl${project.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
      Navigator.of(context).pop();
    } else {
      log("settings jwt unsucessful");
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      project = widget.project;
    });
    retrieveProject();
    getMembersPerRole();
    getVisitorType();
  }

  Future<void> getUserInfo() async {
    SharedPref sharedPref = SharedPref();
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

  void getVisitorType() async {
    await getUserInfo();
    // Check if user is owner
    if (userProfile!.userId == project.ownerId) {
      setState(() {
        visitorType = VisitorType.owner;
      });
      return;
    }

    // Check if user is a project manager or member
    for (var i = 0; i < (project.teamMembers.length); i++) {
      TeamMember member = project.teamMembers[i];

      if (member.userId == userProfile!.userId) {
        if (member.role == "Project Manager") {
          setState(() {
            visitorType = VisitorType.projectManager;
          });
          return;
        } else {
          setState(() {
            visitorType = VisitorType.member;
          });
          return;
        }
      }
    }

    setState(() {
      visitorType = VisitorType.visitor;
    });
  }

  List<String> getAvailableRoles() {
    List<String> availableRoles = [];

    for (var i = 0; i < project.roles.length; i++) {
      var count = project.roles[i].count;

      for (var j = 0; j < project.teamMembers.length; j++) {
        if (project.teamMembers[j].role == project.roles[i].role) {
          count--;
        }
      }

      if (count > 0) {
        availableRoles.add(project.roles[i].role);
      }
    }

    return availableRoles;
  }

  @override
  Widget build(BuildContext context) {
    int memberCount = project.teamMembers.length;

    String daysText = getDaysText(project.projectStartDate, project.deadline);

    Widget beginProjectButton = SmallButton(
      placeholderText: "Begin",
      backgroundColor: approve,
      textColor: Colors.white,
      onPressed: () {
        final confirmModal = ConfirmCancelModal(
          context: context,
          title: "Confirm Beginning Project?",
          approveFunction: () {
            beginProject();
          },
        );
        confirmModal.buildConfirmCancelModal();
      },
    );

    Widget manageTeamButton = SmallButton(
      placeholderText: "Manage Team",
      backgroundColor: neutral,
      textColor: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MembersPage(projectData: project),
          ),
        );
      },
    );

    Widget deleteProjectButton = SmallButton(
      placeholderText: "Delete",
      backgroundColor: danger,
      textColor: Colors.white,
      onPressed: () {
        final confirmModal = ConfirmCancelModal(
          context: context,
          title: "Confirm Deletion of Project?",
          approveFunction: () {
            deleteProject();
          },
        );
        confirmModal.buildConfirmCancelModal();
      },
    );

    Widget inboxButton = SmallButton(
      placeholderText: "Inbox",
      backgroundColor: neutral,
      textColor: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ApplicationPage(projectId: project.id),
          ),
        );
      },
    );

    Widget leaveProjectButton = SmallButton(
      placeholderText: "Leave",
      backgroundColor: danger,
      textColor: Colors.white,
      onPressed: () {
        final confirmModal = ConfirmCancelModal(
          context: context,
          title: "Confirm Leaving Project",
          approveFunction: () {
            leaveProject();
          },
        );
        confirmModal.buildConfirmCancelModal();
      },
    );

    Widget applyProjectButton = SmallButton(
      placeholderText: "Apply",
      backgroundColor: approve,
      textColor: Colors.white,
      onPressed: () {
        final applyModal = ApplyModal(
          context: context,
          projectId: project.id,
          givenRoles: getAvailableRoles(),
        );
        applyModal.buildApplyModal();
      },
    );

    List<Widget> tempControls = [];

    if (visitorType == VisitorType.owner) {
      if (!project.isStarted) {
        tempControls.add(beginProjectButton);
      }
      tempControls.addAll([manageTeamButton, deleteProjectButton, inboxButton]);
    } else if (visitorType == VisitorType.projectManager) {
      if (!project.isStarted) {
        tempControls.add(beginProjectButton);
      }
      tempControls.addAll([manageTeamButton, inboxButton, leaveProjectButton]);
    } else if (visitorType == VisitorType.member) {
      tempControls = [leaveProjectButton];
    } else if (visitorType == VisitorType.visitor) {
      tempControls = [applyProjectButton];
    }

    setState(() {
      controls = [...tempControls];
    });

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          "Back",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Wrap(
                spacing: 5,
                children: controls,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text(
                      memberCount.toString(),
                      textAlign: TextAlign.left,
                    ),
                    const Icon(Icons.person)
                  ]),
                  Row(
                    children: [
                      const Icon(Icons.access_time_filled),
                      Text(
                        daysText,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              const Text(
                "Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(project.description),
              const SizedBox(height: 20),
              const Text(
                "Position Requirements",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                children: roleInfo.map((info) {
                  return Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: RoleBubbles(roleInfo: info),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              const Text(
                "Technologies",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 5,
                children: project.technologies.map((tech) {
                  return TechBubble(technology: tech, editMode: false);
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                "Communications",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: project.communications.map((comm) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: CommunicationBubble(
                        communication: comm, hideLink: false),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
