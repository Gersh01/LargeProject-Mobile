class TeamMember {
  final String role;
  final String userId;
  final String username;

  TeamMember(this.role, this.userId, this.username);

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      json['role'] as String,
      json['userId'] as String,
      json['username'] as String,
    );
  }

  @override
  String toString() {
    return "{role: $role, userId: $userId, username: $username";
  }
}
