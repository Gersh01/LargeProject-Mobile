import 'dart:convert';

import 'package:devfusion/frontend/components/profile/bio_fields.dart';
import 'package:devfusion/frontend/components/profile/technologies_field.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:flutter/material.dart';
import '../components/profile_pictures.dart';
import '../json/Profile.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final String? urlExtension;

  const ProfilePage({super.key, this.urlExtension});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPref sharedPref = SharedPref();
  late Profile? userProfile = null;
  bool profile = true;
  bool loading = true;

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

  Future getUserProjects() async {}

  void checkUrlPath() {
    // var contextCheck = ModalRoute.of(context)?.settings;
    // print(contextCheck);
    // if (contextCheck != null) {
    //   final uri = Uri.parse(contextCheck.name ?? '');
    //   final hasId =
    //       uri.pathSegments.length > 1 && uri.pathSegments[1].isNotEmpty;
    //   print('Current path: ${uri.path}, Has ID: $hasId');
    // }
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
    //getUserProjects();
    // checkUrlPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'League Spartan',
              color: Colors.white
              // color: Theme.of(context).white,
              ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
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
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'League Spartan',
                            color: Colors.white,
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
                          myProfile: true,
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
                          myProfile: true,
                          technologies: userProfile?.technologies ?? [],
                          userInfo: userProfile,
                        )
                      ],
                    )),
                const Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5, right: 10),
                  child: Text(
                    "Projects",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'League Spartan',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}