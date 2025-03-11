import 'package:dio/dio.dart';
import 'dart:async';
import '../models/deck.dart';
import './laravel_api_client.dart';

class DecksService {
  DecksService._() {
    // Constructor riêng để đảm bảo không thể tạo trực tiếp instance
  }

  Future<List<Deck>> fetchDecks({bool filteredByUser = false}) async {
    final List<Deck> decks = [];

    try {
      final client = await LaravelApiClient.getInstance();

      final response = await client.dio.get('/decks', data: {
        'filteredByUser': filteredByUser,
      });

      if (response.statusCode == 200) {
        final data = response.data['decks'] as List;
        for (final deckData in data) {
          decks.add(Deck.fromJson(deckData));
        }
      }

      return decks;
    } catch (error) {
      print('Error fetching decks: $error');
      return decks;
    }
  }

  Future<Deck?> fetchDeckById(String id) async {
    try {
      final client = await LaravelApiClient.getInstance();

      final response = await client.dio.get('/decks/$id');

      if (response.statusCode == 200) {
        final data = response.data['deck'];
        return Deck.fromJson(data);
      }

      return null;
    } catch (error) {
      print('Error fetching deck $id: $error');
      return null;
    }
  }

  Future<Deck?> addDeck(Deck deck) async {
    try {
      final client = await LaravelApiClient.getInstance();

      // Chuẩn bị dữ liệu cho request
      final formData = FormData.fromMap({
        ...deck.toJson(),
      });

      // Thêm file ảnh nếu có
      if (deck.imageBgFile != null) {
        formData.files.add(
          MapEntry(
            'imageBgFile',
            await MultipartFile.fromFile(
              deck.imageBgFile!.path,
              filename: deck.imageBgFile!.path.split('/').last,
            ),
          ),
        );
      }

      // Gọi API để tạo deck mới
      final response = await client.dio.post(
        '/decks',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse dữ liệu từ response
        final data = response.data['deck'];
        return Deck.fromJson(data); 
      }

      return null;
    } catch (error) {
      print('Error adding deck: $error');
      return null;
    }
  }

  Future<Deck?> updateDeck(Deck deck) async {
    try {
      if (deck.id == null) {
        throw Exception('Cannot update deck without id');
      }

      final client = await LaravelApiClient.getInstance();

      FormData formData;

      if (deck.imageBgFile != null) {
        // Thêm phương thức PATCH vào FormData khi có ảnh
        formData = FormData.fromMap({
          ...deck.toJson(),
          '_method': 'PATCH',
          'imageBgFile': await MultipartFile.fromFile(
            deck.imageBgFile!.path,
            filename: deck.imageBgFile!.path.split('/').last,
          ),
        });

        // Sử dụng POST với _method=PATCH để upload file
        final response = await client.dio.post(
          '/decks/${deck.id}',
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          ),
        );

        if (response.statusCode == 200) {
          final data = response.data['deck'];
          return Deck.fromJson(data);
        }
      } else {
        // Sử dụng PATCH thông thường nếu không có file
        final response = await client.dio.patch(
          '/decks/${deck.id}',
          data: deck.toJson(),
        );

        if (response.statusCode == 200) {
          final data = response.data['deck'];
          return Deck.fromJson(data);
        }
      }

      return null;
    } catch (error) {
      print('Error updating deck: $error');
      return null;
    }
  }

  Future<bool> deleteDeck(String id) async {
    try {
      final client = await LaravelApiClient.getInstance();

      final response = await client.dio.delete('/decks/$id');

      return response.statusCode == 200;
    } catch (error) {
      print('Error deleting deck: $error');
      return false;
    }
  }
}
