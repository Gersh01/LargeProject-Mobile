import 'package:devfusion/frontend/json/Role.dart';
import 'package:devfusion/frontend/json/communication.dart';
import 'package:devfusion/frontend/json/team_member.dart';

class Project {
  final String id;
  final String title;
  final bool isOpen;
  final bool isDone;
  final bool isStarted;
  final String description;
  final DateTime projectStartDate;
  final DateTime deadline;
  final List<String> technologies;
  final List<Role> roles;
  final List<Communication> communications;
  final List<TeamMember> teamMembers;

  Project(
    this.id,
    this.title,
    this.description,
    this.isOpen,
    this.isDone,
    this.isStarted,
    this.projectStartDate,
    this.deadline,
    this.technologies,
    this.roles,
    this.communications,
    this.teamMembers,
  );

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      json['_id'] as String,
      json['title'] as String,
      json['description'] as String,
      json['isOpen'] as bool,
      json['isDone'] as bool,
      json['isStarted'] as bool,
      DateTime.parse(json['projectStartDate']),
      DateTime.parse(json['deadline']),
      List.from(json['technologies']),
      (json['roles'] as List)
          .map((roleJson) => Role.fromJson(roleJson))
          .toList(),
      (json['communications'] as List)
          .map((commJson) => Communication.fromJson(commJson))
          .toList(),
      (json['teamMembers'] as List)
          .map((teamMemberJson) => TeamMember.fromJson(teamMemberJson))
          .toList(),
    );
  }

  @override
  String toString() {
    return "{id: $id, title: $title, description: $description, isOpen: $isOpen, isDone: $isDone, $isStarted: isStarted, projectStartDate: $projectStartDate, deadline: $deadline, technologies: $technologies, roles: $roles, communications: $communications, teamMembers: $teamMembers}";
  }
}
