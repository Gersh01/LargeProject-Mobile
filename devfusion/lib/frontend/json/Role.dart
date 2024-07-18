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

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['role'] = role;
    data['count'] = count;
    data['description'] = description;

    return data;
  }

  @override
  String toString() {
    return "{role: $role, count: $count}";
  }
}
