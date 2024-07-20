import '../../json/team_member.dart';

class MembersPerRole {
  String? role;
  int? count;
  String? description;
  List<TeamMember>? members;

  MembersPerRole(this.role, this.count, this.description, this.members);

  @override
  String toString() {
    return "{role: $role, count: $count, description: $description, members: $members}";
  }
}
