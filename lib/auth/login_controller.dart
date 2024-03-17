import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_service.dart';import 'package:get/get.dart';
import 'login_model.dart';
import 'login_service.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> login() async {
    _isLoading = true;
    update();

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    final loginResponse = await _loginService.login(username, password);

    _isLoading = false;
    update();

    if (loginResponse.success) {
      // Handle successful login
      final loginModel = loginResponse.data;
      // Navigate to the next screen or perform any other actions
      // print('Login successful: $loginModel');
      print('Login successful: Token = ${loginModel!.token}');
    } else {
      // Handle login failure
      final errorMessage = loginResponse.error;
      Get.dialog(
        AlertDialog(
          title: const Text('Login Failed'),
          content: Text(errorMessage ?? 'An unknown error occurred'),
          actions: [
            TextButton(
              onPressed: Get.back,
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}