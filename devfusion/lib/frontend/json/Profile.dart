class Profile {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String bio;
  final List<String> technologies;
  final String link;

  Profile(this.userId, this.firstName, this.lastName, this.email, this.username,
      this.bio, this.technologies, this.link);

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      json['id'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String,
      json['username'] as String,
      json['bio'] as String,
      List.from(json['technologies']),
      json['link'] as String,
    );
  }

  @override
  String toString() {
    return "{id: $userId, firstName: $firstName, lastName: $lastName, email: $email, username: $username, bio: $bio, technologies: $technologies, link: $link}";
  }
}
