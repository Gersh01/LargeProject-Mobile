import 'package:flutter/material.dart';

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
  bool editMode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 200,
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
              editMode
                  ? Container(
                      child: const Row(
                      children: [],
                    ))
                  : Text("")
            ],
          ),
        ],
      ),
    ));
  }
}
