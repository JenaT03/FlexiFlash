import 'package:flutter/material.dart';

import '../../models/user.dart';

class UsersManager with ChangeNotifier {
  final List<User> _users = [
    User(
      id: 'u1',
      name: 'user 1',
      email: 'user1@gmail.com',
      password: '12345678',
    ),
    User(
      id: 'u2',
      name: 'user 2',
      email: 'user2@gmail.com',
      password: '12345678',
    ),
  ];

  User? _currentUser; // Thêm biến để lưu user hiện tại

  User? get currentUser => _currentUser; // Getter để truy cập currentUser

  bool get isAuth => _currentUser != null; // Kiểm tra đã đăng nhập chưa

  bool login(String email, String password) {
    final userIndex = _users.indexWhere(
      (user) => user.email == email && user.password == password,
    );

    if (userIndex >= 0) {
      _currentUser = _users[userIndex];
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void register(User user) {
    _users.add(
      user.copyWith(
        id: 'u${DateTime.now().toIso8601String()}',
      ),
    );
    notifyListeners();
  }

  void updateUser(User user) {
    final index = _users.indexWhere((user) => user.id == user.id);

    if (index >= 0) {
      _users[index] = user;
      notifyListeners();
    }
  }
}
