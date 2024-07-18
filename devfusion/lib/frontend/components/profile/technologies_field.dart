import 'dart:convert';

import 'package:devfusion/frontend/json/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/utility.dart';
import '../bubbles/tech_bubble.dart';
import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:http/http.dart' as http;

class TechnologiesField extends StatefulWidget {
  final bool myProfile;
  final List<String> technologies;
  final Profile? userInfo;

  const TechnologiesField({
    super.key,
    required this.myProfile,
    required this.technologies,
    required this.userInfo,
  });
  @override
  State<TechnologiesField> createState() => _TechnologiesField();
}

class _TechnologiesField extends State<TechnologiesField> {
  _TechnologiesField() {
    // _dropDownValue = updatedTechList[0];
  }

  bool editMode = false;

  final TextEditingController _techSearchController = TextEditingController();
  String _selectedValue = "";
  List<String> updatedTechList = [];
  List<String> userTechnologies = [];
  SharedPref sharedPref = SharedPref();
  final addIcon = Icons.add;

  @override
  void initState() {
    _techSearchController.text;
    userTechnologies = widget.technologies;
    super.initState();
  }

  void addTechnology() async {
    var newTechnologies;
    bool exists = false;
    userTechnologies = widget.technologies;
    for (int i = 0; i < userTechnologies.length; i++) {
      if (_selectedValue.toString() == userTechnologies[i]) {
        exists = true;
      }
    }
    if (_selectedValue != "Searching..." && exists == false) {
      String? token = await sharedPref.readToken();

      newTechnologies = widget.technologies;
      newTechnologies.add(_selectedValue);

      var reqBody = {
        "token": token,
        "userId": widget.userInfo?.userId,
        "technologies": newTechnologies,
      };
      var response = await http.put(
        Uri.parse(updateUserUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      if (response.statusCode == 200) {
        setState(() {
          userTechnologies = newTechnologies;
        });
      } else {
        print("Projects have been updated!");
      }
    }
  }

  void deleteTechnology(String techName) async {
    List<String> newTechnologies;

    userTechnologies = widget.technologies;
    if (techName != "") {
      String? token = await sharedPref.readToken();

      newTechnologies = userTechnologies;
      newTechnologies.remove(techName);

      var reqBody = {
        "token": token,
        "userId": widget.userInfo?.userId,
        "technologies": newTechnologies,
      };
      var response = await http.put(
        Uri.parse(updateUserUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      if (response.statusCode == 200) {
        setState(() {
          userTechnologies = newTechnologies;
        });
      } else {
        print("Projects have been updated!");
      }
    }
  }

  void getTechnologiesList(String tech) {
    List<String> techList = getTechnolgies(_techSearchController.text);
    techList.insert(0, "Searching...");
    setState(() {
      updatedTechList = techList;
    });
  }

  void dropDownCallback(String? selectedValue) {
    if (selectedValue is String) {
      _selectedValue = selectedValue;
    }
  }

  void updateUserTechnologies() async {}

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Technologies",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'League Spartan',
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
              widget.myProfile
                  ? IconButton(
                      icon: Icon(
                          color: Theme.of(context).hintColor,
                          !editMode
                              ? Icons.mode_edit_outline
                              : Icons.keyboard_double_arrow_up_outlined),
                      onPressed: () {
                        setState(() {
                          editMode = !editMode;
                        });
                      },
                    )
                  : Text(""),
            ],
          ),
          editMode
              ? Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: Container(
                          width: 300,
                          padding: const EdgeInsets.only(
                              left: 5.0, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            controller: _techSearchController,
                            onChanged: getTechnologiesList,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Theme.of(context).hintColor,
                            ),
                            decoration: const InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                hintText: "Type to search"),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                          height: 37,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 5, bottom: 10, right: 5),
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              isExpanded: true,
                              dropdownColor:
                                  Theme.of(context).primaryColorLight,
                              hint: const Text('Searching...'),
                              onChanged: dropDownCallback,
                              items: updatedTechList.map((String tech) {
                                return DropdownMenuItem<String>(
                                  value: tech,
                                  child: Text(
                                    tech,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                );
                              }).toList())),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: IconButton(
                        onPressed: addTechnology,
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).hintColor,
                        )),
                  )
                ])
              : Text(""),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: editMode
                        ? BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(10))
                        : null,
                    child: Wrap(
                        spacing: 8,
                        clipBehavior: Clip.hardEdge,
                        children: userTechnologies.map((techBubbles) {
                          return TechBubble(
                              technology: techBubbles,
                              editMode: editMode,
                              delete: deleteTechnology);
                        }).toList()),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
