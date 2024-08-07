import 'dart:convert';
import 'dart:developer';

import 'package:devfusion/frontend/components/Button.dart';
import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:devfusion/themes/theme.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ApplyModalAlertDialog extends StatefulWidget {
  final String projectId;
  final List<String> givenRoles;

  const ApplyModalAlertDialog({
    super.key,
    required this.projectId,
    required this.givenRoles,
  });

  @override
  State<ApplyModalAlertDialog> createState() => _ApplyModalAlertDialogState();
}

class _ApplyModalAlertDialogState extends State<ApplyModalAlertDialog> {
  SharedPref sharedPref = SharedPref();
  String? userId;
  String success = "";
  double successCount = 0;
  String error = "";
  double errorCount = 0;
  String selectedRole = "";
  Text? hintText;
  TextEditingController descriptionController = TextEditingController();

  void getUserCredentials() async {
    setState(() {
      successCount = 0;
      errorCount = 0;
    });

    String? token = await sharedPref.readToken();
    var reqBody = {"token": token};

    var response = await http.post(
      Uri.parse(jwtUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      log("settings jwt sucessful");
      var jsonResponse = jsonDecode(response.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
      userId = jsonResponse['id'];
    } else {
      log("settings jwt unsucessful");
    }
  }

  Future apply(String role) async {
    if (selectedRole == "Select an Available Role" ||
        selectedRole == "No Roles Available" ||
        selectedRole == "") {
      setState(() {
        error = "Choose an available role";
        errorCount = 1;
      });
      return;
    }

    String? token = await sharedPref.readToken();

    var reqBody = {
      "role": selectedRole,
      "projectId": widget.projectId,
      "userId": userId,
      "token": token,
      "description": descriptionController.text,
    };

    var response = await http.post(
      Uri.parse(applyInboxUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );
    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 201) {
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
      setState(() {
        success = "Applied";
        successCount = 1;
      });
    } else {
      setState(() {
        error = jsonResponse['error'];
        errorCount = 1;
      });
    }
  }

  @override
  void initState() {
    getUserCredentials();
    if (widget.givenRoles.isNotEmpty) {
      hintText = const Text(
        "Select an Available Role",
        overflow: TextOverflow.ellipsis,
      );
    } else {
      hintText = const Text(
        "No Roles Available",
        overflow: TextOverflow.ellipsis,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Application",
        style: TextStyle(
          fontSize: 22,
        ),
      ),
      content: SizedBox(
        width: 50,
        child: ListView(
          shrinkWrap: true,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Desired Role",
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            // ApplyDropDown(roles: widget.givenRoles, selectedRole: selectedRole),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).primaryColorDark,
              ),
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
                hint: hintText,
                // style: const TextStyle(color: Colors.deepPurple),
                items: widget.givenRoles.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRole = newValue!;
                    // print(
                    //     "SelectedRole in dropdown: $newValue and $selectedRole");
                  });
                  // setState(() {
                  //   _dropdownValue = newValue!;
                  // });
                },
                // value: _dropdownValue,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).primaryColorDark,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Description"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      maxLines: 5,
                      decoration: const InputDecoration.collapsed(
                          hintText: "Tell us about yourself..."),
                      controller: descriptionController,
                      readOnly: false,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              error,
              style: TextStyle(
                color: danger,
                fontSize: 14 * errorCount,
              ),
            ),
            Text(
              success,
              style: const TextStyle(
                color: approve,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
      actions: [
        Button(
          // height: 25,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'League Spartan',
            color: Colors.white,
          ),
          // width: 120,
          placeholderText: 'Apply',
          backgroundColor: approve,
          textColor: Colors.white,
          onPressed: () async {
            apply("API");
          },
        ),
        Button(
          // height: 25,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'League Spartan',
            color: Colors.white,
          ),
          // width: 120,
          placeholderText: 'Cancel',
          backgroundColor: danger,
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      // actionsAlignment: MainAxisAlignment.spaceBetween,
      elevation: 20,
      backgroundColor: Theme.of(context).primaryColorLight,
    );
  }
}
