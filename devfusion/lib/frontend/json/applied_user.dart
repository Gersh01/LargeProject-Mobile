class AppliedUser {
  final String userId;
  final String username;
  final String role;
  String description;

  AppliedUser(this.userId, this.username, this.role, this.description);

  factory AppliedUser.fromJson(Map<String, dynamic> json) {
    return AppliedUser(
      json['userId'] as String,
      json['username'] as String,
      json['role'] as String,
      json['description'] as String,
    );
  }

  @override
  String toString() {
    return "{userId: $userId, username: $username, role: $role, description: $description}";
  }
}
