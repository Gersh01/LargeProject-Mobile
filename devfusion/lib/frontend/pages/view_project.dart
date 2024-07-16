import 'package:flutter/material.dart';
import '../components/manage_team/members_per_role.dart';
import '../components/Divider.dart';
import '../components/bubbles/tech_bubble.dart';
import '../json/Project.dart';
import '../json/Role.dart';
import '../json/communication.dart';
import '../json/team_member.dart';
import '../components/Button.dart';
import '../pages/members_page.dart';
import '../components/manage_team/role_bubbles.dart';

class ViewProject extends StatefulWidget {
  final Project project;

  const ViewProject({super.key, required this.project});

  @override
  State<ViewProject> createState() => _ViewProjectState();
}

class _ViewProjectState extends State<ViewProject> {
  late List<MembersPerRole> roleInfo;
  late List<TeamMember> teamMembers;

  void getMembersPerRole() {
    roleInfo = [];
    for (int i = 0; i < widget.project.roles.length; i++) {
      teamMembers = [];
      for (int j = 0; j < widget.project.teamMembers.length; j++) {
        if (widget.project.roles[i].role ==
            widget.project.teamMembers[j].role) {
          teamMembers.add(widget.project.teamMembers[j]);
        }
      }
      roleInfo.add(MembersPerRole(
          widget.project.roles[i].role,
          widget.project.roles[i].count,
          widget.project.roles[i].description,
          teamMembers));
    }
  }

  void initState() {
    super.initState();
    getMembersPerRole();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.project.title);

    int currentCount = widget.project.teamMembers.length;

    String daysText = "";

    if (widget.project.projectStartDate.isAfter(DateTime.now())) {
      int days =
          widget.project.projectStartDate.difference(DateTime.now()).inDays;

      if (days > 1) {
        daysText = "$days days until Start";
      } else {
        daysText = "$days day until Start";
      }
    } else {
      int days = widget.project.deadline.difference(DateTime.now()).inDays;

      if (days > 1) {
        daysText = "$days days until project begins";
      } else {
        daysText = "$days day until project begins";
      }
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(),
        body: ListView(children: [
          Center(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.project.title),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Text(
                    currentCount.toString(),
                    textAlign: TextAlign.left,
                  ),
                  Icon(Icons.person)
                ]),
                Row(
                  children: [
                    Icon(Icons.access_time_filled),
                    Text(
                      daysText,
                      textAlign: TextAlign.left,
                    ),
                  ],
                )
              ]),
              Divider(),
              Text("Description",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(widget.project.description),
              Button(
                placeholderText: "Manage Team",
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MembersPage(projectData: widget.project)))
                },
              ),
              Text("Position Requirements",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ]),
          ),
          //These are the role bubbles with the user_bubbles inside
          Column(
            children: roleInfo.map((info) {
              return Container(child: RoleBubbles(roleInfo: info));
            }).toList(),
          ),
          Text("Technologies"),
          Wrap(children: [
            for (String tech in widget.project.technologies)
              TechBubble(technology: tech, editMode: false)
          ]),
          Text("Communications"),
          for (Communication communication in widget.project.communications)
            Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(communication.name),
                  Text(communication.link)
                ]))
        ]));
  }
}
