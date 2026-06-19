import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class RegisController extends GetxController {
  final AuthService _authService = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final agreeTerms = false.obs;
  final errorMessage = ''.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void toggleAgreeTerms() {
    agreeTerms.value = !agreeTerms.value;
  }

  void _showError(String message) {
    errorMessage.value = message;
    Get.snackbar(
      'Registration Failed',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1A1A1A),
      colorText: Colors.white,
    );
  }

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty) {
      _showError('Full name is required');
      return;
    }
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      _showError('Please enter a valid email');
      return;
    }
    if (password.isEmpty || password.length < 6) {
      _showError('Password must be at least 6 characters');
      return;
    }
    if (password != confirmPassword) {
      _showError('Passwords do not match');
      return;
    }
    if (!agreeTerms.value) {
      _showError('Please agree to Terms & Privacy Policy');
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    await Future.delayed(const Duration(milliseconds: 600));

    final result = await _authService.register(
      name: name,
      email: email,
      password: password,
    );

    isLoading.value = false;

    if (result == null) {
      Get.snackbar(
        'Success',
        'Account created! Please sign in.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE50914),
        colorText: Colors.white,
      );
      Get.back();
    } else {
      _showError(result);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
