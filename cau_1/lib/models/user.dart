class User {
  final int id;
  final String name;
  final String email;
  final String username;
  final String phone;
  final String website;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.website,
  });

  // Factory method to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
    );
  }

  // Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,
      'website': website,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, username: $username, phone: $phone, website: $website)';
  }
}
