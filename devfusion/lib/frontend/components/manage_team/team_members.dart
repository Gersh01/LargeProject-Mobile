import 'package:flutter/material.dart';
import '../../json/Project.dart';

class TeamMembers extends StatefulWidget {
  final Project ProjectData;

  const TeamMembers({
    super.key,
    required this.ProjectData,
  });

  @override
  State<TeamMembers> createState() => _TeamMembers();
}

class _TeamMembers extends State<TeamMembers> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
