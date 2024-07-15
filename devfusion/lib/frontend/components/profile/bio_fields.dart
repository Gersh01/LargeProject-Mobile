import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'package:devfusion/frontend/json/Profile.dart';
import '../../utils/utility.dart';

class BioFields extends StatefulWidget {
  final bool myProfile;
  final String bioMessage;
  final Profile? userProfile;
  const BioFields({
    super.key,
    required this.myProfile,
    required this.bioMessage,
    required this.userProfile,
  });

  @override
  State<BioFields> createState() => _BioFields();
}

class _BioFields extends State<BioFields> {
  bool editMode = false;

  final TextEditingController _bioController = TextEditingController();
  SharedPref sharedPref = SharedPref();
  void updateBio() async {
    String bioMessage = _bioController.text;

    if (bioMessage != "") {
      String? token = await sharedPref.readToken();

      var reqBody = {
        "token": token,
        "userId": widget.userProfile?.userId,
        "bio": bioMessage,
      };
      var response = await http.put(
        Uri.parse(updateUserUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      if (response.statusCode == 200) {
        setState(() {
          _bioController.text = bioMessage;
        });
      } else {
        print("Projects have been updated!");
      }
    }
  }

  void getProfileInfo() {
    setState(() {
      _bioController.text = widget.bioMessage;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          height: 250,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Bio",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'League Spartan',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  widget.myProfile
                      ? IconButton(
                          icon: Icon(!editMode
                              ? Icons.mode_edit_outline
                              : Icons.keyboard_double_arrow_up_outlined),
                          onPressed: () {
                            setState(() {
                              editMode = !editMode;
                            });
                            if (editMode == false) {
                              updateBio();
                            }
                          },
                        )
                      : Text("")
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: editMode
                              ? Theme.of(context).primaryColorLight
                              : null),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: TextField(
                          maxLines: 6,
                          decoration: const InputDecoration.collapsed(
                              hintText: "Tell us about yourself..."),
                          controller: _bioController,
                          readOnly: !editMode,
                        ),
                      )))
            ],
          )),
    );
  }
}
