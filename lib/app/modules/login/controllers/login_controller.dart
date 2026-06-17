import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // ─── Text Controllers ──────────────────────────────────────────
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ─── Reactive Variables ────────────────────────────────────────
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  final errorMessage = ''.obs;

  // ─── Methods ───────────────────────────────────────────────────
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    // TODO: Isi logic login (hit API / validasi)
    isLoading.value = true;
    errorMessage.value = '';

    await Future.delayed(const Duration(seconds: 2)); // ganti dengan API call

    isLoading.value = false;
    // Contoh navigasi setelah login berhasil:
    // Get.offAllNamed('/home');
  }

  void navigateToRegister() {
    // TODO: navigasi ke halaman register
    // Get.toNamed('/register');
  }

  void forgotPassword() {
    // TODO: navigasi ke halaman lupa password
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}