class SignupRequest {
  String? name;
  String? email;
  String? password;
  String? rePassword;
  String? phone;

  SignupRequest({
    this.name,
    this.email,
    this.password,
    this.rePassword,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'rePassword': rePassword,
        'phone': phone,
      };
}
