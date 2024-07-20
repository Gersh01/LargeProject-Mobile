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

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['link'] = link;

    return data;
  }

  @override
  String toString() {
    return "{name: $name, link: $link}";
  }
}
