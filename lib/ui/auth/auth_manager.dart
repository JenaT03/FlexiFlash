import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../services/auth_service.dart';

import '../../models/user.dart';

class AuthManager with ChangeNotifier {
  final AuthService _authService;
  User? _loggedInUser;
  StreamSubscription? _authSubscription;

  AuthManager() : _authService = AuthService() {
    // Lắng nghe sự thay đổi trạng thái xác thực
    _authSubscription = _authService.authStateChanges.listen((User? user) {
      _loggedInUser = user;
      notifyListeners();
    });
  }

  bool get isAuth {
    return _loggedInUser != null;
  }

  User? get user {
    return _loggedInUser;
  }

  Future<User> register(String email, String password) {
    return _authService.register(email, password);
  }

  Future<User> login(String email, String password) {
    return _authService.login(email, password);
  }

  Future<void> tryAutoLogin() async {
    final user = await _authService.getUserFromToken();

    if (_loggedInUser != null) {
      _loggedInUser = user;
      notifyListeners();
    }
  }

  String? getEmail() {
    return _loggedInUser?.email;
  }

  Future<void> changeEmail(String email) async {
    final user = await _authService.changeEmail(email);

    if (_loggedInUser != null) {
      _loggedInUser = user;
      notifyListeners();
    }
  }

  Future<bool?> changePass(
      String currentPass, String newPass, String confirmPass) async {
    final result =
        await _authService.changePass(currentPass, newPass, confirmPass);

    return result;
  }

  Future<void> logout() {
    return _authService.logout();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _authService.dispose();
    super.dispose();
  }
}
