import 'dart:async';
import '../models/deck.dart';
import './laravel_api_client.dart';
import 'package:dio/dio.dart';

class DecksService {
  Deck customeUrl(Deck initDeck) {
    final String storageUrl =
        'http://10.3.2.37:8000/storage/'; // http://10.0.2.2:8000/storage/ trên VM
    Deck deck = initDeck;
    deck = deck.copyWith(imageBg: "$storageUrl${deck.imageBg}");
    return deck;
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
          Deck deck = Deck.fromJson(deckData);
          decks.add(customeUrl(deck));
        }
      }

      return decks;
    } catch (error) {
      print('Lỗi khi fetching decks: $error');
      return decks;
    }
  }

  Future<Deck?> fetchDeckById(String id) async {
    try {
      final client = await LaravelApiClient.getInstance();
      final response = await client.dio.get('/decks/$id');
      if (response.statusCode == 200) {
        final data = response.data['deck'];
        Deck deck = Deck.fromJson(data);
        return customeUrl(deck);
      }

      return null;
    } catch (error) {
      print('Lỗi khi fetching deck $id: $error');
      return null;
    }
  }

  Future<Deck?> addDeck(Deck deck) async {
    try {
      final client = await LaravelApiClient.getInstance();
      final userId = await client.getUserId();
      final response = await client.dio.post(
        '/decks',
        data: FormData.fromMap({
          ...deck.toJson(),
          'userId': userId,
          if (deck.imageBgFile != null)
            'imageBgFile': await MultipartFile.fromFile(
              deck.imageBgFile!.path,
              filename: deck.imageBgFile!.uri.pathSegments.last,
            ),
        }),
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      Deck addedDeck = Deck.fromJson(response.data['deck']);
      return customeUrl(addedDeck);
    } catch (e) {
      if (e is DioException) {
        print('Lỗi khi thêm deck: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
      } else {
        print('Lỗi không xác định: $e');
      }
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
          Deck updatedDeck = Deck.fromJson(response.data['deck']);

          return customeUrl(updatedDeck);
        }
      } else {
        // Sử dụng PATCH thông thường nếu không có file
        final response = await client.dio.patch(
          '/decks/${deck.id}',
          data: deck.toJson(),
        );

        if (response.statusCode == 200) {
          Deck updatedDeck = Deck.fromJson(response.data['deck']);

          return customeUrl(updatedDeck);
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
