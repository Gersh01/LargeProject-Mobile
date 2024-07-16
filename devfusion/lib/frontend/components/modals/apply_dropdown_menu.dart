import 'package:flutter/material.dart';

class ApplyDropDown extends StatefulWidget {
  final List<String> roles;

  const ApplyDropDown({
    super.key,
    required this.roles,
    // required this.projectId,
  });

  @override
  State<ApplyDropDown> createState() => _ApplyDropDownState();
}

class _ApplyDropDownState extends State<ApplyDropDown> {
  // String? _dropdownValue;
  Text? hintText;

  @override
  void initState() {
    if (widget.roles.isNotEmpty) {
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
    // _dropdownValue = widget.roles[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(hintText);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).primaryColorDark,
      ),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        hint: hintText,
        // style: const TextStyle(color: Colors.deepPurple),
        items: widget.roles.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          // setState(() {
          //   _dropdownValue = newValue!;
          // });
        },
        // value: _dropdownValue,
      ),
    );
  }
}
