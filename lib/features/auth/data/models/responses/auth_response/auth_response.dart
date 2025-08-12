import 'user_info.dart';

class AuthResponse {
	String? message;
	UserInfo? user;
	String? token;

	AuthResponse({this.message, this.user, this.token});

	factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
				message: json['message'] as String?,
				user: json['user'] == null
						? null
						: UserInfo.fromJson(json['user'] as Map<String, dynamic>),
				token: json['token'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'message': message,
				'user': user?.toJson(),
				'token': token,
			};
}
