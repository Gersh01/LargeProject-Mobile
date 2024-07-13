import 'package:flutter/material.dart';

class BioFields extends StatefulWidget {
  final bool myProfile;
  final String bioMessage;
  const BioFields({
    super.key,
    required this.myProfile,
    required this.bioMessage,
  });

  @override
  State<BioFields> createState() => _BioFields();
}

class _BioFields extends State<BioFields> {
  bool editMode = false;

  final TextEditingController _bioController = TextEditingController();

  void getProfileInfo() {
    setState(() {
      _bioController.text = widget.bioMessage;
    });
  }

  @override
  void initState() {
    getProfileInfo();
    super.initState();
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
                          },
                        )
                      : Text("")
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  maxLines: 6,
                  decoration: const InputDecoration.collapsed(
                      hintText: "Tell us about yourself..."),
                  controller: _bioController,
                  readOnly: !editMode,
                ),
              )
            ],
          )),
    );
  }
}
