class AuthenticationModel {
  //Constructor
  AuthenticationModel({
    required this.id,
    required this.email,
    required this.name,
  });

  final String id;
  final String email;
  final String name;

  factory AuthenticationModel.fromMap(Map<String, dynamic> map) {
    print('INI MODEL USER');
    return AuthenticationModel(
      id: map['id'] as String? ?? '',
      email: map['email'] as String? ?? '',
      name: map['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}
