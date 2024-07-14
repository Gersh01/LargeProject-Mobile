import 'package:devfusion/frontend/json/applied_user.dart';

class Inbox {
  final String projectTitle;
  final List<AppliedUser> appliedUsers;

  Inbox(this.projectTitle, this.appliedUsers);

  factory Inbox.fromJson(Map<String, dynamic> json) {
    return Inbox(
      json['projectTitle'] as String,
      (json['appliedUsers'] as List)
          .map((appliedUserJson) => AppliedUser.fromJson(appliedUserJson))
          .toList(),
    );
  }

  @override
  String toString() {
    return "{projectTitle: $projectTitle, appliedUsers: $appliedUsers}";
  }
}
