import '../../models/deck.dart';

import 'package:flutter/foundation.dart';
import '../../services/decks_service.dart';

class DecksManager with ChangeNotifier {
  final DecksService _decksService = DecksService();
  List<Deck> _decks = [
    Deck(
      id: 'd1',
      title: 'Nấm độc tại rừng quốc gia Việt Nam',
      type: 'Sinh học',
      imageBg:
          'https://toongadventure.vn/wp-content/uploads/2021/05/amy-humphries-fdeVkxtyymk-unsplash.jpg',
      userId: 'u1',
    ),
  ];

  // Getter để lấy tất cả deck
  List<Deck> get decks => [..._decks];

  // Getter để lấy số lượng deck
  int get deckCount => _decks.length;

  List<Deck> get favoriteDecks {
    return _decks.where((deck) => deck.isFavorite).toList();
  }

  Deck? findById(String id) {
    try {
      final deck = _decks.firstWhere((deck) => deck.id == id);
      print('deckmig ${deck.imageBg}');
      return deck;
    } catch (error) {
      return null;
    }
  }

  // Lấy deck theo userId
  List<Deck> getDecksByUser(String userId) {
    return _decks.where((deck) => deck.userId == userId).toList();
  }

  // Thêm deck mới
  Future<String?> addDeck(Deck deck) async {
    final newDeck = await _decksService.addDeck(deck);
    if (newDeck != null) {
      _decks.add(newDeck);
      notifyListeners();
      return newDeck.id;
    }
  }

  // Cập nhật deck
  Future<String?> updateDeck(Deck deck) async {
    final index = _decks.indexWhere((item) => item.id == deck.id);

    if (index >= 0) {
      final updatedDeck = await _decksService.updateDeck(deck);
      if (updatedDeck != null) {
        _decks[index] = updatedDeck;
        notifyListeners();
        return updatedDeck.id;
      }
    }
  }

  // Xóa deck
  Future<void> deleteDeck(String id) async {
    final index = _decks.indexWhere((deck) => deck.id == id);

    if (index >= 0 && !await _decksService.deleteDeck(id)) {
      _decks.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> fetchDecks() async {
    _decks = await _decksService.fetchDecks();
    notifyListeners();
  }

  Future<void> fetchDeckById(String id) async {
    Deck? deck = await _decksService.fetchDeckById(id);
    if (deck != null) {
      String? deckId = deck.id;
      final index = _decks.indexWhere((deck) => deck.id != deckId);
      if (index <= 0) {
        _decks.add(deck);

        notifyListeners();
      }
    }
  }

  Future<void> fetchUserDecks() async {
    _decks = await _decksService.fetchDecks(filteredByUser: true);
    notifyListeners();
  }
}
