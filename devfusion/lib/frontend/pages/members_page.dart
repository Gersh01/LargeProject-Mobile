import 'dart:convert';
import 'package:devfusion/frontend/components/Divider.dart';
import 'package:devfusion/frontend/components/manage_team/role_bubbles.dart';
import 'package:devfusion/frontend/components/manage_team/roles_per_member.dart';
import 'package:devfusion/frontend/json/team_member.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:flutter/material.dart';
import '../json/Project.dart';
import '../components/shared_pref.dart';
import '../json/Profile.dart';
import 'package:http/http.dart' as http;
import '../components/manage_team/members_per_role.dart';
import '../components/manage_team/manage_member_tile.dart';

class MembersPage extends StatefulWidget {
  final Project projectData;

  const MembersPage({
    super.key,
    required this.projectData,
  });

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  SharedPref sharedPref = SharedPref();
  late List<MembersPerRole> roleInfo;
  late List<TeamMember>? teamMembers = widget.projectData.teamMembers;
  late List<RolesPerMember> rolesPerMembers;
  late List<String> membersProssibleRoles;
  late String projectId = widget.projectData.id;
  bool loading = true;
  late Profile? userProfile;

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
      print("settings jwt unsucessful");
    }
  }

  //Gets the members for every role
  void getMembersPerRole() {
    roleInfo = [];
    for (int i = 0; i < widget.projectData.roles.length; i++) {
      teamMembers = [];
      for (int j = 0; j < widget.projectData.teamMembers.length; j++) {
        if (widget.projectData.roles[i].role ==
            widget.projectData.teamMembers[j].role) {
          teamMembers!.add(widget.projectData.teamMembers[j]);
        }
      }
      roleInfo.add(MembersPerRole(
          widget.projectData.roles[i].role,
          widget.projectData.roles[i].count,
          widget.projectData.roles[i].description,
          teamMembers));
    }
  }

  //Finds available roles the user can join
  void getRolesPerMember() {
    rolesPerMembers = [];
    for (int i = 0; i < widget.projectData.teamMembers.length; i++) {
      membersProssibleRoles = [];
      for (int j = 0; j < widget.projectData.roles.length; j++) {
        if (widget.projectData.teamMembers[i].role !=
            widget.projectData.roles[j].role) {
          membersProssibleRoles.add(widget.projectData.roles[j].role);
        }
      }
      rolesPerMembers.add(RolesPerMember(
          widget.projectData.teamMembers[i].username,
          widget.projectData.teamMembers[i].role,
          membersProssibleRoles));
    }
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
    getMembersPerRole();
    getRolesPerMember();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).hintColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Manage Team',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'League Spartan',
            color: Theme.of(context).hintColor,
            // color: Theme.of(context).white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              children: [
                const DividerLine(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Current Positions",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'League Spartan',
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
                Column(
                  children: roleInfo.map((info) {
                    return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: RoleBubbles(roleInfo: info));
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: rolesPerMembers.map((member) {
                    return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: ManageMemberTile(
                          projectId: projectId,
                          members: widget.projectData.teamMembers,
                          membersRoleInfo: member,
                        ));
                  }).toList(),
                )
              ],
            ),
    );
  }
}
