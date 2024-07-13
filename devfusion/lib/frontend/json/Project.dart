import 'package:devfusion/frontend/json/Role.dart';

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
  );

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      json['_id'] as String,
      json['title'] as String,
      json['description'] as String,
      json['isOpen'] as bool,
      json['isDone'] as bool,
      json['isStarted'] as bool,
      DateTime.parse(json['dateCreated']),
      DateTime.parse(json['deadline']),
      List.from(json['technologies']),
      (json['roles'] as List)
          .map((roleJson) => Role.fromJson(roleJson))
          .toList(),
    );
  }

  @override
  String toString() {
    return "{id: $id, title: $title, description: $description, isOpen: $isOpen, isDone: $isDone, $isStarted: isStarted, projectStartDate: $projectStartDate, deadline: $deadline, ${technologies.toString()} roles: $roles}";
  }
}
