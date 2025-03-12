import 'dart:async';
import '../models/deck.dart';
import './laravel_api_client.dart';
import 'package:dio/dio.dart';

class DecksService {
  Future<Deck?> addDeck(Deck deck) async {
    final client = await LaravelApiClient.getInstance();
    final userId = await client.getUserId();
    try {
      final response = await client.dio.post(
        '/decks',
        data: FormData.fromMap({
          ...deck.toJson(),
          'userId': userId,
          if (deck.featuredImage != null)
            'imageBg': await MultipartFile.fromFile(
              deck.featuredImage!.path,
              filename: deck.featuredImage!.uri.pathSegments.last,
            ),
        }),
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return Deck.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        print('Lỗi khi thêm deck: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
      } else {
        print('Lỗi không xác định: $e');
      }
    }
  }
}
