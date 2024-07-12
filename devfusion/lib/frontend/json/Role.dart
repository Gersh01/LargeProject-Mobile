class Role {
  final String role;
  final int count;
  final String description;

  Role(this.role, this.count, this.description);

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      json['role'] as String,
      json['count'] as int,
      json['description'] as String,
    );
  }

  @override
  String toString() {
    return "{role: $role, count: $count}";
  }
}
