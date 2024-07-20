class RolesPerMember {
  String username;
  String role;
  List<String> possibleRoles;

  RolesPerMember(
    this.username,
    this.role,
    this.possibleRoles,
  );

  @override
  String toString() {
    return "{username: $username, role: $role, possible: $possibleRoles}";
  }
}
