class UserModel {
  String name;

  String email;

  UserModel({
    required this.email,
    required this.name,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
    );
  }
}
