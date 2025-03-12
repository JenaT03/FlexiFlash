import 'package:dio/dio.dart';
import 'dart:async';
import '../models/flashcard.dart';
import './laravel_api_client.dart';

class FlashcardsService {
  FlashcardsService._() {
    // Constructor riêng để đảm bảo không thể tạo trực tiếp instance
  }

  Future<List<Flashcard>> fetchFlashcards({required String deckId}) async {
    final List<Flashcard> flashcards = [];

    try {
      final client = await LaravelApiClient.getInstance();

      final response = await client.dio.get('/decks/$deckId/flashcards');

      if (response.statusCode == 200) {
        final data = response.data['flashcards'] as List;
        for (final flashcardData in data) {
          flashcards.add(Flashcard.fromJson(flashcardData));
        }
      }

      return flashcards;
    } catch (error) {
      print('Error fetching flashcards: $error');
      return flashcards;
    }
  }

  Future<Flashcard?> fetchFlashcardById({
    required String deckId,
    required String flashcardId,
  }) async {
    try {
      final client = await LaravelApiClient.getInstance();

      final response =
          await client.dio.get('/decks/$deckId/flashcards/$flashcardId');

      if (response.statusCode == 200) {
        final data = response.data['flashcard'];
        return Flashcard.fromJson(data);
      }

      return null;
    } catch (error) {
      print('Error fetching flashcard $flashcardId: $error');
      return null;
    }
  }

  Future<Flashcard?> addFlashcard(
      {required String deckId, required Flashcard flashcard}) async {
    try {
      final client = await LaravelApiClient.getInstance();

      // Chuẩn bị dữ liệu cho request
      final formData = FormData.fromMap({
        ...flashcard.toJson(),
      });

      // Thêm file ảnh nếu có
      if (flashcard.imageFile != null) {
        formData.files.add(
          MapEntry(
            'imageFile',
            await MultipartFile.fromFile(
              flashcard.imageFile!.path,
              filename: flashcard.imageFile!.path.split('/').last,
            ),
          ),
        );
      }

      // Gọi API để tạo deck mới
      final response = await client.dio.post(
        '/decks/$deckId/flashcards',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse dữ liệu từ response
        final data = response.data['flashcard'];
        return Flashcard.fromJson(data);
      }

      return null;
    } catch (error) {
      print('Error adding flashcard: $error');
      return null;
    }
  }

  Future<Flashcard?> updateFlashcard({
    required String deckId,
    required Flashcard flashcard,
  }) async {
    try {
      if (flashcard.id == null) {
        throw Exception('Cannot update flashcard without id');
      }

      final client = await LaravelApiClient.getInstance();

      FormData formData;

      if (flashcard.imageFile != null) {
        // Thêm phương thức PATCH vào FormData khi có ảnh
        formData = FormData.fromMap({
          ...flashcard.toJson(),
          '_method': 'PATCH',
          'imageFile': await MultipartFile.fromFile(
            flashcard.imageFile!.path,
            filename: flashcard.imageFile!.path.split('/').last,
          ),
        });

        // Sử dụng POST với _method=PATCH để upload file
        final response = await client.dio.post(
          '/decks/$deckId/flashcards/${flashcard.id}',
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          ),
        );

        if (response.statusCode == 200) {
          final data = response.data['flashcard'];
          return Flashcard.fromJson(data);
        }
      } else {
        // Sử dụng PATCH thông thường nếu không có file
        final response = await client.dio.patch(
          '/decks/$deckId/flashcards/${flashcard.id}',
          data: flashcard.toJson(),
        );

        if (response.statusCode == 200) {
          final data = response.data['flashcard'];
          return Flashcard.fromJson(data);
        }
      }

      return null;
    } catch (error) {
      print('Error updating flashcard: $error');
      return null;
    }
  }

  Future<bool> deleteFlashcard({
    required String deckId,
    required String flashcardId,
  }) async {
    try {
      final client = await LaravelApiClient.getInstance();

      final response =
          await client.dio.delete('/decks/$deckId/flashcards/$flashcardId');

      return response.statusCode == 200;
    } catch (error) {
      print('Error deleting flashcard: $error');
      return false;
    }
  }
}
