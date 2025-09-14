class Category {
  final int id;
  final String name;
  final String type;
  final String user;
  final DateTime createdAt;

  Category({
    required this.id,
    required this.name,
    required this.type,
    required this.user,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      user: json['user'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "type": type,
    };
  }
}
