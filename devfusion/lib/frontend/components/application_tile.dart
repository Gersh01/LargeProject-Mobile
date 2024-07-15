import 'dart:convert';

import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/json/applied_user.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApplicationTile extends StatefulWidget {
  final String projectId;
  final AppliedUser appliedUser;
  final void Function() onReload;

  const ApplicationTile(
      {super.key,
      required this.projectId,
      required this.appliedUser,
      required this.onReload});

  @override
  State<ApplicationTile> createState() => _ApplicationTileState();
}

class _ApplicationTileState extends State<ApplicationTile> {
  final messageLength = 200;

  Future onButtonClick(bool accept) async {
    SharedPref sharedPref = SharedPref();

    var token = await sharedPref.readToken();

    Object reqBody = {
      "token": token,
      "projectId": widget.projectId,
      "userId": widget.appliedUser.userId,
      "role": widget.appliedUser.role,
    };

    var response = await http.post(
      Uri.parse(accept ? acceptInboxUrl : rejectInboxUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      widget.onReload();
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.appliedUser.description =
        widget.appliedUser.description.length > messageLength
            ? "${widget.appliedUser.description.substring(0, messageLength)}..."
            : widget.appliedUser.description;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).focusColor,
            Theme.of(context).highlightColor,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Theme.of(context).primaryColorLight,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).focusColor,
                    Theme.of(context).highlightColor,
                  ],
                ),
              ),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        widget.appliedUser.role,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "@${widget.appliedUser.username}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            onButtonClick(true);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green[600],
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: "poppins",
                              fontWeight: FontWeight.w700,
                            ),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            padding: const EdgeInsets.all(0),
                          ),
                          child: const Text("Accept"),
                        ),
                        const SizedBox(width: 8),
                        // Reject button
                        TextButton(
                          onPressed: () {
                            onButtonClick(false);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red[600],
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: "poppins",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            padding: const EdgeInsets.all(0),
                          ),
                          child: const Text("Reject"),
                        ),
                      ],
                    ),
                    // Accept button
                  ],
                )
              ]),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Theme.of(context).primaryColorLight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // const SizedBox(height: 10),
                Text(
                  widget.appliedUser.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
