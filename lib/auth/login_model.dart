class LoginModel {
  final String? token;
  final int? userId;

  LoginModel({this.token, this.userId});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'] as String?, // Handles null values
      userId: json['userId'] as int?, // Handles null values
    );
  }
}
