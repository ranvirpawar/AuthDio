import 'dart:convert';
import 'package:dio/dio.dart';
import 'login_model.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<LoginResponse> login(String username, String password) async {
    print('Attempting login with username: $username and password: $password');

    try {
      final response = await _dio.post(
        'https://dummyjson.com/auth/login',
        data: jsonEncode({
          'username': username,
          'password': password,
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Login successful');
        final loginData = LoginModel.fromJson(response.data);
        print('Login data: $loginData');
        return LoginResponse(success: true, data: loginData);
      } else {
        print('Login failed: ${response.statusMessage}');
        return LoginResponse(
          success: false,
          error: 'Login failed: ${response.statusMessage}',
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      return LoginResponse(
        success: false,
        error: 'Error occurred: $e',
      );
    }
  }
}

class LoginResponse {
  final bool success;
  final LoginModel? data;
  final String? error;

  LoginResponse({
    required this.success,
    this.data,
    this.error,
  });
}
