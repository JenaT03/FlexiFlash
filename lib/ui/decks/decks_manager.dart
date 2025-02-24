import '../../models/deck.dart';

import 'package:flutter/foundation.dart';

class DeckManager with ChangeNotifier {
  final List<Deck> _decks = [
    Deck(
      id: 'd1',
      title: 'GIT',
      imageBg: 'assets/images/bg_git.png',
      userId: 'u1',
    ),
    Deck(
      id: 'd2',
      title: 'Từ vựng tiếng Anh TOEIC',
      imageBg: 'assets/images/bg_toeic.png',
      userId: 'u1',
    ),
    Deck(
      id: 'd3',
      title: 'Từ vựng tiếng Anh TOEIC',
      imageBg: 'assets/images/bg_img.jpg',
      userId: 'u1',
    ),
    Deck(
      id: 'd4',
      title: 'Từ vựng tiếng Anh TOEIC',
      imageBg: 'assets/images/bg_img.jpg',
      userId: 'u1',
    ),
    Deck(
      id: 'd5',
      title: 'Từ vựng tiếng Anh TOEIC',
      imageBg: 'assets/images/bg_img.jpg',
      userId: 'u1',
    ),
    Deck(
      id: 'd6',
      title: 'Từ vựng tiếng Anh TOEIC',
      imageBg: 'assets/images/bg_img.jpg',
      userId: 'u1',
    ),
    Deck(
      id: 'd7',
      title: 'Từ vựng tiếng Anh TOEIC',
      imageBg: 'assets/images/bg_img.jpg',
      userId: 'u1',
    ),
    Deck(
      id: 'd8',
      title: 'Từ vựng tiếng Anh TOEIC',
      imageBg: 'assets/images/bg_img.jpg',
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
      return _decks.firstWhere((deck) => deck.id == id);
    } catch (error) {
      return null;
    }
  }

  // Lấy deck theo userId
  List<Deck> getDecksByUser(String userId) {
    return _decks.where((deck) => deck.userId == userId).toList();
  }

  // Thêm deck mới
  void addDeck(Deck deck) {
    final newDeck = deck.copyWith(
      id: 'd${DateTime.now().toIso8601String()}',
    );
    _decks.add(newDeck);
    notifyListeners();
  }

  // Cập nhật deck
  void updateDeck(Deck deck) {
    final index = _decks.indexWhere((item) => item.id == deck.id);

    if (index >= 0) {
      _decks[index] = deck;
      notifyListeners();
    }
  }

  // Xóa deck
  void deleteDeck(String id) {
    final index = _decks.indexWhere((deck) => deck.id == id);

    if (index >= 0) {
      _decks.removeAt(index);
      notifyListeners();
    }
  }

  // Toggle trạng thái yêu thích
  // void toggleFavorite(String deckId) {
  //   final deck = findById(deckId);
  //   final updatedDeck = deck.copyWith(isFavorite: !deck.isFavorite);
  //   final index = _decks.indexWhere((deck) => deck.id == deckId);
  //   _decks[index] = updatedDeck;
  //   notifyListeners();
  // }
}
