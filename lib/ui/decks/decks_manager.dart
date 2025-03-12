import '../../models/deck.dart';

import 'package:flutter/foundation.dart';
import '../../services/decks_service.dart';

class DecksManager with ChangeNotifier {
  final DecksService _decksService = DecksService();
  final List<Deck> _decks = [
    Deck(
      id: 'd1',
      title: 'Nấm độc tại rừng quốc gia Việt Nam',
      type: 'Sinh học',
      imageBg:
          'https://toongadventure.vn/wp-content/uploads/2021/05/amy-humphries-fdeVkxtyymk-unsplash.jpg',
      userId: 'u1',
    ),
    Deck(
      id: 'd2',
      title: 'Các thuyết vaath lý lượng tử',
      type: 'Vật lý',
      imageBg:
          'https://happy.live/wp-content/uploads/2019/02/vat-ly-luong-tu-happy-live7.jpg',
      userId: 'u1',
    ),
    Deck(
      id: 'd3',
      title: 'Các loại chim trong sách đỏ Việt Nam',
      type: 'Sinh học',
      imageBg:
          'https://img.giaoduc.net.vn/w700/Uploaded/2025/fcivpcvo/2012_09_11/cac-loai-dong-vat-co-trong-sach-do-viet-nam-129.jpg',
      userId: 'u1',
    ),
    Deck(
      id: 'd4',
      title: 'Đất hiếm',
      type: 'Hóa học',
      imageBg:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhw7_TFWx3VBVmP1c879zm2idhES4Ri966RPmvsV0WtDVnpPLbTTIq06fqW8evaUhfGiINT54bNJmgWImtflJMPcSOXfja-NmuSiLoekMiHom62eEpmTeGH1WFy9Wxj4Y1jRDOTDRSluqM/s400/coban+2.jpg',
      userId: 'u1',
    ),
    Deck(
      id: 'd5',
      title: 'Tổng thống Hoa Kỳ',
      type: 'Lịch sử',
      imageBg:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Gilbert_Stuart_Williamstown_Portrait_of_George_Washington_%28cropped%29%282%29.jpg/225px-Gilbert_Stuart_Williamstown_Portrait_of_George_Washington_%28cropped%29%282%29.jpg',
      userId: 'u1',
    ),
    Deck(
      id: 'd6',
      title: 'Các núi cao nhất thế giới',
      type: 'Địa lý',
      imageBg:
          'https://danviet.mediacdn.vn/296231569849192448/2024/4/19/everest-top-10-dinh-nui-cao-nhat-the-gioi-hien-nay-1713518663885-17135186640951526466027.jpg',
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
  Future<void> addDeck(Deck deck) async {
    final newDeck = await _decksService.addDeck(deck);
    if (newDeck != null) {
      _decks.add(newDeck);
      notifyListeners();
    }
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
