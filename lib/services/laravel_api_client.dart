import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaravelApiClient {
  static LaravelApiClient? _instance;
  final Dio _dio = Dio();
  String? _accessToken;
  bool _isInitialized = false;

  LaravelApiClient._();

  Future<void> initialize() async {
    if (_isInitialized) return;

    final baseUrl = dotenv.env['LARAVEL_API_URL'] ?? 'http://10.0.2.2:8000/api';
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
    _dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    // Load token từ SharedPreferences
    await _loadTokenFromStorage();

    // Interceptor để thêm token vào mỗi request
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_accessToken != null) {
          options.headers['Authorization'] = 'Bearer $_accessToken';
        }
        return handler.next(options);
      },
      onError: (DioError error, handler) {
        // Xử lý lỗi 401 (Unauthorized) - có thể implement refresh token ở đây
        if (error.response?.statusCode == 401) {
          // Xóa token và thông báo cần đăng nhập lại
          clearToken();
          // Có thể thông báo qua một Stream để các widget lắng nghe
        }
        return handler.next(error);
      },
    ));

    // Thêm dòng này để đánh dấu rằng đã khởi tạo xong
    _isInitialized = true;
  }

  static Future<LaravelApiClient> getInstance() async {
    if (_instance == null) {
      _instance = LaravelApiClient._();
    }

    // Đảm bảo client đã được khởi tạo
    if (!_instance!._isInitialized) {
      await _instance!.initialize();
    }

    return _instance!;
  }

  Future<void> _loadTokenFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _accessToken = prefs.getString('access_token');
    } catch (e) {
      print('LOG ---- Error loading token: $e');
    }
  }

  Future<void> setToken(String token) async {
    _accessToken = token;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', token);
    } catch (e) {
      print('LOG ---- Error saving token: $e');
    }
  }

  Future<void> clearToken() async {
    _accessToken = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
    } catch (e) {
      print('LOG ---- Error clearing token: $e');
    }
  }

  Dio get dio {
    if (!_isInitialized) {
      throw Exception(
          'LaravelApiClient not initialized. Call getInstance() first.');
    }
    return _dio;
  }

  bool get hasToken => _accessToken != null;

  Future<String?> getUserId() async {
    try {
      final response = await _dio.get('/account');
      return response.data['user']['id'].toString();
    } catch (e) {
      print('Lỗi khi lấy userId: $e');
      return null;
    }
  }
}
