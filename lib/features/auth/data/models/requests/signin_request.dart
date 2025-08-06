class SigninRequest {
  String? email;
  String? password;

  SigninRequest({this.email, this.password});

  factory SigninRequest.fromJson(Map<String, dynamic> json) => SigninRequest(
        email: json['email'] as String?,
        password: json['password'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
