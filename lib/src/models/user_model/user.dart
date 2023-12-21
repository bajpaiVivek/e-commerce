class UserModel {
  final String username;
  final String roles;

  UserModel({required this.username, required this.roles});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      roles: json['roles'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'username': username, 'roles': roles};
  }
}
