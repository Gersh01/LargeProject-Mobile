import '../../json/team_member.dart';

class MembersPerRole {
  String? role;
  int? count;
  List<TeamMember>? members;

  MembersPerRole(this.role, this.count, this.members);

  @override
  String toString() {
    return "{role: $role, count: $count, members: $members}";
  }
}
