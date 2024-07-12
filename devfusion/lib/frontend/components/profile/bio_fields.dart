import 'dart:ffi';

import 'package:flutter/material.dart';

class BioFields extends StatefulWidget {
  final bool myProfile;
  final String? bioMessage;
  final bool edit;

  const BioFields({
    super.key,
    required this.myProfile,
    required this.edit,
    this.bioMessage,
  });

  @override
  State<BioFields> createState() => _BioFields();
}

class _BioFields extends State<BioFields> {
  bool editMode = false;

  final TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          height: 300,
          decoration: const BoxDecoration(
              color: Color(0xffF9FAFB),
              borderRadius: BorderRadius.all(Radius.circular(10))),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'League Spartan',
                        color: Colors.black,
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
                      : Text("")
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  maxLines: 8,
                  decoration: InputDecoration.collapsed(
                      hintText: "Tell us about yourself..."),
                  controller: _bioController,
                  readOnly: edit,
                ),
              )
            ],
          )),
    );
  }
}
