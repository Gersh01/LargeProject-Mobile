class Communication {
  final String name;
  final String link;

  Communication(this.name, this.link);

  factory Communication.fromJson(Map<String, dynamic> json) {
    return Communication(
      json['name'] as String,
      json['link'] as String,
    );
  }

  @override
  String toString() {
    return "{name: $name, link: $link}";
  }
}
