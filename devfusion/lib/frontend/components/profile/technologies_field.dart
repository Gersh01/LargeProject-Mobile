import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/utility.dart';
import '../tech_bubble.dart';

class TechnologiesField extends StatefulWidget {
  final bool myProfile;
  final List<String> technologies;

  const TechnologiesField({
    super.key,
    required this.myProfile,
    required this.technologies,
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
  String? _dropDownValue = "Searching...";
  List<String> updatedTechList = [];

  List<String> testTech = [
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
    "React",
  ];

  final addIcon = Icons.add;

  @override
  void initState() {
    _techSearchController.text;
    super.initState();
  }

  void addTechnology() {
    setState(() {});
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
      setState(() {
        _dropDownValue = selectedValue;
      });
      print("Setting the dropdownvalue = " + _dropDownValue.toString());
    }
  }

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
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Technologies",
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
                      },
                    )
                  : Text(""),
            ],
          ),
          editMode
              ? Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5),
                      child: Container(
                          width: 300,
                          padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                          decoration: BoxDecoration(
                              color: const Color(0xff374151),
                              borderRadius: BorderRadius.circular(10)),
                          child: SizedBox(
                              height: 30,
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(20)
                                ],
                                controller: _techSearchController,
                                onChanged: getTechnologiesList,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    hintText: "Type to search"),
                              ))),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5),
                      child: Container(
                          height: 34,
                          decoration: BoxDecoration(
                            color: const Color(0xff374151),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton(
                            padding: EdgeInsets.all(2),
                            items: updatedTechList
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            value: _dropDownValue,
                            dropdownColor: Color(0xff374151),
                            menuMaxHeight: 200,
                            isExpanded: true,
                            onChanged: dropDownCallback,
                            hint: Text("Help"),
                            underline: Container(
                              height: 0,
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: IconButton(
                        onPressed: addTechnology, icon: Icon(Icons.add)),
                  )
                ])
              : Text(""),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Wrap(
                    spacing: 8,
                    clipBehavior: Clip.hardEdge,
                    children: testTech.map((techBubbles) {
                      return TechBubble(technology: techBubbles);
                    }).toList(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
