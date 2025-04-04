import 'package:dio/dio.dart';
import 'dart:async';
import '../models/flashcard.dart';
import './laravel_api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlashcardsService {
  Flashcard customeUrl(Flashcard initFlashcard) {
    final String storageUrl = dotenv.env['LARAVEL_STORAGE_URL'] ??
        'http://10.3.2.37:8000/storage/'; // http://10.0.2.2:8000/storage/ trên VM
    Flashcard flashcard = initFlashcard;
    flashcard = flashcard.copyWith(imgURL: "$storageUrl${flashcard.imgURL}");

    return flashcard;
  }

  Future<List<Flashcard>> fetchFlashcards({required String deckId}) async {
    final List<Flashcard> flashcards = [];
    try {
      final client = await LaravelApiClient.getInstance();

      final response = await client.dio.get('/decks/$deckId/flashcards');
      if (response.statusCode == 200) {
        final data = response.data['flashcards'] as List;
        for (final flashcardData in data) {
          Flashcard flashcard = Flashcard.fromJson(flashcardData);
          flashcards.add(customeUrl(flashcard));
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
      final response = await client.dio.post(
        '/decks/$deckId/flashcards',
        data: FormData.fromMap({
          ...flashcard.toJson(),
          if (flashcard.imageFile != null)
            'imageFile': await MultipartFile.fromFile(
              flashcard.imageFile!.path,
              filename: flashcard.imageFile!.uri.pathSegments.last,
            ),
        }),
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      Flashcard addedFlashcard = Flashcard.fromJson(response.data['flashcard']);
      return customeUrl(addedFlashcard);
    } catch (error) {
      print('Lỗi adding flashcard: $error');
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
          Flashcard flashcard = Flashcard.fromJson(response.data['flashcard']);
          return customeUrl(flashcard);
        }
      } else {
        // Sử dụng PATCH thông thường nếu không có file
        final response = await client.dio.patch(
          '/decks/$deckId/flashcards/${flashcard.id}',
          data: flashcard.toJson(),
        );

        if (response.statusCode == 200) {
          Flashcard flashcard = Flashcard.fromJson(response.data['flashcard']);
          return customeUrl(flashcard);
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

  Future<List<Flashcard>> fetchMarkedFlashcards() async {
    final List<Flashcard> flashcards = [];
    try {
      final client = await LaravelApiClient.getInstance();

      final response = await client.dio.get('/marked-flashcards');
      if (response.statusCode == 200) {
        final data = response.data['flashcards'] as List;
        for (final flashcardData in data) {
          Flashcard flashcard = Flashcard.fromJson(flashcardData);
          flashcards.add(customeUrl(flashcard));
        }
      }

      return flashcards;
    } catch (error) {
      print('Error fetching marked flashcards: $error');
      return flashcards;
    }
  }
}
