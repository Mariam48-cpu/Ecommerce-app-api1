class SignupModel {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;
  final String creationAt;
  final String updatedAt;

  SignupModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
    required this.creationAt,
    required this.updatedAt,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      id: json["id"],
      email: json["email"],
      password: json["password"],
      name: json["name"],
      role: json["role"],
      avatar: json["avatar"],
      creationAt: json["creationAt"],
      updatedAt: json["updatedAt"],
    );
  }
}
