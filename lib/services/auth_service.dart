import 'package:dio/dio.dart';
import 'dart:async';
import '../models/user.dart';
import './laravel_api_client.dart';

class AuthService {
  final StreamController<User?> _authStateController =
      StreamController<User?>.broadcast();
  Stream<User?> get authStateChanges => _authStateController.stream;

  // AuthService() {}

  Future<User> register(String email, String password) async {
    final client = await LaravelApiClient.getInstance();

    try {
      final response = await client.dio.post('/register', data: {
        'email': email,
        'password': password,
      });

      // Lấy thông tin user từ response hoặc gọi API riêng
      final user = User.fromJson(response.data['user']);
      return user;
    } catch (error) {
      if (error is DioException) {
        if (error.response?.data != null) {
          final errorMsg =
              error.response?.data['message'] ?? 'Registration failed';
          throw Exception(errorMsg);
        }
      }
      throw Exception('An error occurred during registration');
    }
  }

  Future<User> login(String email, String password) async {
    try {
      print('LOG ---- Starting login process...');
      final client = await LaravelApiClient.getInstance();
      print('LOG ---- API client obtained successfully');

      try {
        print('LOG ---- Sending login request...');
        final response = await client.dio.post('/login', data: {
          'email': email,
          'password': password,
        });
        print('LOG ---- Login response received: ${response.statusCode}');

        // Xử lý kết quả đăng nhập
        if (response.statusCode == 200) {
          // Lưu token
          final token = response.data['token'] ?? response.data['access_token'];
          print('LOG ---- Token received: ${token != null ? 'Yes' : 'No'}');
          await client.setToken(token);
          print('LOG ---- Token saved successfully');
        }
        // Lấy thông tin user
        final user = User.fromJson(response.data['user']);
        print('LOG ---- User object created: ${user.email}');
        _authStateController.add(user);
        print('LOG ---- Auth state updated');
        return user;
      } catch (error) {
        if (error is DioException) {
          print('LOG ---- Dio error: ${error.type}');
          print('LOG ---- Response: ${error.response?.data}');
          if (error.response?.data != null) {
            final errorMsg = error.response?.data['message'] ?? 'Login failed';
            throw Exception(errorMsg);
          }
        }
        throw Exception('An error occurred during login: $error');
      }
    } catch (e) {
      print('LOG ---- Unhandled exception: $e');
      throw e;
    }
  }

  Future<void> logout() async {
    final client = await LaravelApiClient.getInstance();

    try {
      // Gọi API logout
      await client.dio.post('/logout');
    } catch (e) {
      // Xử lý lỗi nhưng vẫn xóa token local
    } finally {
      // Luôn xóa token dù API thành công hay thất bại
      await client.clearToken();
      _authStateController.add(null);
    }
  }

  Future<User?> getUserFromToken() async {
    final client = await LaravelApiClient.getInstance();

    if (!client.hasToken) {
      return null;
    }

    try {
      // Gọi API để lấy thông tin user từ token
      final response = await client.dio.get('/account');
      final user = User.fromJson(response.data['user']);

      // Thông báo cho các listener về user mới
      _authStateController.add(user);

      return user;
    } catch (e) {
      // Nếu lỗi, xóa token và trả về null
      await client.clearToken();
      _authStateController.add(null);
      return null;
    }
  }

  void dispose() {
    _authStateController.close();
  }
}
