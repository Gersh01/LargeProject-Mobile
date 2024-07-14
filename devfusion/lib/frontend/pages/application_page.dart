import 'dart:convert';

import 'package:devfusion/frontend/components/application_tile.dart';
import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/json/inbox.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApplicationPage extends StatefulWidget {
  final String projectId;

  const ApplicationPage({super.key, required this.projectId});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  late Inbox inbox = Inbox("abc", []);

  @override
  void initState() {
    super.initState();
    fetchInbox();
  }

  Future fetchInbox() async {
    SharedPref sharedPref = SharedPref();

    var token = await sharedPref.readToken();

    var reqBody = {
      "token": token,
    };

    var request = http.Request(
      'GET',
      Uri.parse("$getInboxUrl${widget.projectId}"),
    )..headers.addAll(
        {"Content-Type": "application/json"},
      );

    request.body = jsonEncode(reqBody);
    var response = await request.send();

    if (response.statusCode == 200) {
      var inboxData = await response.stream.bytesToString();
      setState(
        () {
          inbox = Inbox.fromJson(
            jsonDecode(inboxData),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Applications',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'League Spartan',
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(0, 4.0),
                blurRadius: 20.0,
                color: Color.fromRGBO(0, 0, 0, 0.4),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromRGBO(31, 41, 55, 1),
      ),
      body: Column(
        //Project Cards
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Text(
              inbox.projectTitle,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: inbox.appliedUsers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("There are no applications at this time..."),
                        TextButton(
                          onPressed: () async {
                            await fetchInbox();
                          },
                          child: const Text("Refresh"),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: inbox.appliedUsers.length,
                    itemBuilder: (BuildContext context, int index) {
                      var appliedUser = inbox.appliedUsers[index];
                      return ApplicationTile(
                        projectId: widget.projectId,
                        appliedUser: appliedUser,
                        onReload: () async {
                          await fetchInbox();
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
