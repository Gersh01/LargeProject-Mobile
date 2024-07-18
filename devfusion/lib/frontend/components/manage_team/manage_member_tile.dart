import 'dart:convert';

import 'package:devfusion/frontend/json/team_member.dart';
import 'package:flutter/material.dart';
import '../manage_team/roles_per_member.dart';
import '../shared_pref.dart';
import '../../utils/utility.dart';
import 'package:http/http.dart' as http;
import '../modals/confirm_cancel_modal.dart';

class ManageMemberTile extends StatefulWidget {
  final RolesPerMember membersRoleInfo;
  final String? projectId;
  final List<TeamMember>? members;

  const ManageMemberTile({
    super.key,
    required this.membersRoleInfo,
    this.projectId,
    this.members,
  });

  State<ManageMemberTile> createState() => _ManageMemberTile();
}

class _ManageMemberTile extends State<ManageMemberTile> {
  SharedPref sharedPref = SharedPref();
  String _selectedValue = "";

  void initState() {
    super.initState();
  }

  void dropDownCallback(String? selectedValue) {
    if (selectedValue is String) {
      _selectedValue = selectedValue;
    }
  }

  Future updateMemberRole() async {
    String? token = await sharedPref.readToken();
    List<TeamMember> newMembersRoles = [];
    for (int i = 0; i < widget.members!.length; i++) {
      if (widget.members?[i].username == widget.membersRoleInfo.username) {
        print(
            "${widget.members?[i].username} == ${widget.membersRoleInfo.username}");
        newMembersRoles.add(TeamMember(
          _selectedValue,
          widget.members![i].userId,
          widget.members![i].username,
        ));
      } else {
        newMembersRoles.add(widget.members![i]);
      }
    }
    var reqBody = {
      "token": token,
      "projectId": widget.projectId,
      "teamMembers": newMembersRoles
    };

    var response = await http.put(Uri.parse(editTeamMembersUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var response2 = jsonDecode(response.body);
    if (response.statusCode == 200) {
    } else {
      print(response2['error']);
      print(response2.statusCode);
    }
  }

  Future removeMember() async {
    String? token = await sharedPref.readToken();
    List<TeamMember> newMembersRoles = [];
    for (int i = 0; i < widget.members!.length; i++) {
      if (widget.members?[i].username != widget.membersRoleInfo.username) {
        newMembersRoles.add(widget.members![i]);
      }
    }

    var reqBody = {
      "token": token,
      "projectId": widget.projectId,
      "teamMembers": newMembersRoles
    };

    var response = await http.put(Uri.parse(editTeamMembersUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var response2 = jsonDecode(response.body);
    if (response.statusCode == 200) {
    } else {
      print(response2['error']);
    }
  }

  void showAcceptModal() {
    var confirmCancelModal = ConfirmCancelModal(
        context: context,
        title: "Are you sure you want to remove the user?",
        approveFunction: removeMember);
    confirmCancelModal.buildConfirmCancelModal();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(minHeight: 180),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          gradient: LinearGradient(colors: [
                            Theme.of(context).highlightColor,
                            Theme.of(context).focusColor
                          ])),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "${widget.membersRoleInfo!.username}",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).hintColor,
                              fontStyle: FontStyle.italic),
                        ),
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10),
              child: Row(
                children: [
                  Text(
                    "Current Role:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "${widget.membersRoleInfo!.role}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).hintColor),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: Row(
                children: [
                  Text(
                    "Change Role: ",
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColorDark),
                    child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5, right: 5),
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        isExpanded: true,
                        dropdownColor: Theme.of(context).primaryColorDark,
                        hint: const Text('No change'),
                        onChanged: dropDownCallback,
                        items: widget.membersRoleInfo.possibleRoles
                            .map((String role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(
                              role,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          );
                        }).toList()),
                  ),
                ],
              ),
            ),
            //Updating the users Roles
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: ElevatedButton(
                      onPressed: updateMemberRole,
                      style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.green[700])),
                      child: Text(
                        "Update",
                        style: TextStyle(
                            color: Theme.of(context).hintColor, fontSize: 18),
                      ),
                    ),
                  ),
                  //Removing the user from the project
                  ElevatedButton(
                    onPressed: showAcceptModal,
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        backgroundColor:
                            WidgetStateProperty.all(Colors.red[700])),
                    child: Text(
                      "Remove",
                      style: TextStyle(
                          color: Theme.of(context).hintColor, fontSize: 18),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
