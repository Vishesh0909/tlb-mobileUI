import 'package:flutter/material.dart';

/// Simple global auth state using ValueNotifier
class AuthState {
  static final ValueNotifier<bool> isLoggedIn = ValueNotifier<bool>(false);
  static String? userName;
  static String? userPhone;

  static void login({String? name, String? phone}) {
    userName = name ?? 'User';
    userPhone = phone;
    isLoggedIn.value = true;
  }

  static void logout() {
    userName = null;
    userPhone = null;
    isLoggedIn.value = false;
  }
}
