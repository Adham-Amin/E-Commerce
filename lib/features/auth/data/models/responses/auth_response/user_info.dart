class UserInfo {
  String? name;
  String? email;
  String? role;

  UserInfo({this.name, this.email, this.role});

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        name: json['name'] as String?,
        email: json['email'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'role': role,
      };
}
