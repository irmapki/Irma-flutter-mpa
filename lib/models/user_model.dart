class User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String roles;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      roles: json['roles'],
    );
  }
}